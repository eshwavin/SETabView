//
//  SEViewController.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 15/02/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

open class SETabViewController: UIViewController, AnimatedTabViewProperties {
    
    private let resetAnimationDuration: Double = 0.5
    
    // MARK: - AnimatedTabViewProperties
    public var tintColor: UIColor {
        set {
            SETabSettings.current.tintColor = newValue
            _tabBar?.tabTintColorDidChange()
        }
        get {
            return SETabSettings.current.tintColor
        }
    }
    public var barTintColor: UIColor {
        set {
            SETabSettings.current.barTintColor = newValue
            _tabBar?.barTintColorDidChange()
        }
        get {
            return SETabSettings.current.barTintColor
        }
    }
    public var unselectedItemTintColor: UIColor {
        set {
            SETabSettings.current.unselectedItemTintColor = newValue
            _tabBar?.unselectedItemTintColorDidChange()
        }
        get {
            return SETabSettings.current.unselectedItemTintColor
        }
    }
    public var backgroundColor: UIColor {
        set {
            SETabSettings.current.backgroundColor = newValue
            _tabBar?.backgroundColorDidChange()
        }
        get {
            return SETabSettings.current.backgroundColor
        }
    }
    
    public var ballColor: UIColor {
        set {
            SETabSettings.current.ballColor = newValue
            _tabBar?.ballColorDidChange()
        }
        get {
            return SETabSettings.current.ballColor
        }
    }
    
    // MARK: - Properties: TabBar
    private var lastSelectedTabIndex: Int?
    private let tabBarHeight: CGFloat = 60
    /// the index of the view controller associated with the currently selected tab item
    public var selectedIndex: Int {
        get {
            return _tabBar.selectedTabIndex
        }
        set {
            
            guard selectedIndex < _viewControllers.count && selectedIndex > -1 else {
                return
            }
            
            func handleTabChange() {
                _tabBar.selectedTabIndex = newValue
                moveToViewController(at: newValue)
            }
            
            if _tabBar.isSetup {
                handleTabChange()
            }
            else {
                _tabBar.closureAfterSetup = {
                    handleTabChange()
                }
            }
            
        }
    }
    
    // MARK: - Properties: Views/View Controllers
    private var _tabBar: AnimatedTabViewProtocol!
    public var tabBar: AnimatedTabViewProperties {
        return self as AnimatedTabViewProperties
    }
    private var bottomFillerView: UIView! // view to fill the space between home control and safe area
    public var animationType: AnimationType = .holeBall1 {
        didSet {
            guard _viewControllers.count > 0, animationType != oldValue else { return }
            resetAnimationType(indexToSelect: selectedIndex)
        }
    }
    
    public var viewControllers: [UIViewController] {
        get {
            _viewControllers.elements
        }
        set {
            _viewControllers = OrderedSet(newValue)
        }
    }
    
    private var _viewControllers: OrderedSet<UIViewController> = [] {
        didSet {
            
            lastSelectedTabIndex = nil
            
            // removing entire view if there are no view controllers
            guard !_viewControllers.isEmpty else {
                _tabBar?.removeFromSuperview()
                bottomFillerView?.removeFromSuperview()
                view.subviews.forEach { $0.removeFromSuperview() }
                return
            }
            
            let newViewControllers = _viewControllers.subtracting(oldValue)
            
            newViewControllers.forEach(addChild(_:))
            newViewControllers.forEach {
                $0.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight, right: 0)
            }
            
            if !oldValue.isEmpty {
                
                var newIndexToSelect: Int? = nil
                // removing old view controllers
                let removedViewControllers = oldValue.subtracting(_viewControllers)
                
                removedViewControllers.forEach { (removedViewController) in
                    removedViewController.removeFromParent()
                    if removedViewController === oldValue[selectedIndex] {
                        UIView.animate(withDuration: resetAnimationDuration) {
                            removedViewController.view.alpha = 0
                        } completion: { _ in
                            removedViewController.view.removeFromSuperview()
                        }
                    }
                    else {
                        removedViewController.view.removeFromSuperview()
                    }
                    
                }
                
                // setting newIndexToSelect as index of selected UIViewController if it exists in new list
                newIndexToSelect = _viewControllers.firstIndex(of: oldValue[selectedIndex])
                // if not set yet setting the value of newIndexToSelect to the first UIViewController present in the old list that is also present in the new list
                if newIndexToSelect == nil {
                    for oldViewController in oldValue {
                        if let index = _viewControllers.firstIndex(of: oldViewController) {
                            newIndexToSelect = index
                            break
                        }
                    }
                }
                
                isResetting = true
                resetAnimationType(indexToSelect: newIndexToSelect ?? 0)
            }
            else {
                self.setupViews()
                self.setTabIcons()
                selectedIndex = _tabBar.selectedTabIndex
            }
        }
    }
    
    private var isResetting: Bool = false
    
    // MARK: - LifeCycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    
    /// Setup the TabBar along with animation behaviour
    /// - Parameters:
    ///   - viewControllers: The embedded view controllers of the tab bar
    ///   - animationType: The type of animation of the tab bar, default value is holeBall1
    public func setViewControllers(_ viewControllers: [UIViewController]) {
        if viewControllers.count > 6 {
            print("SETabViewController Error: Cannot handle more than 5 UIViewControllers. Using the first 5 UIViewControllers")
        }
        self._viewControllers = OrderedSet(viewControllers.prefix(5))
    }
    
    /// Change the default look and animation duration of the SETabView
    /// - Parameters:
    ///   - tabColor: The color of the tab bar. Default value is UIColor.black
    ///   - ballColor: The color of the ball. Default value is UIColor.black
    ///   - selectedTabTintColor: The tint of the tab item when selected. Default value is UIColor.white
    ///   - deselectedTabTintColor: The tint of the tab item when selected. Default value is UIColor.gray
    public func setTabColors(backgroundColor: UIColor, ballColor: UIColor, tintColor: UIColor, unselectedItemTintColor: UIColor, barTintColor: UIColor) {
        
        SETabSettings.current.backgroundColor = backgroundColor
        SETabSettings.current.ballColor = ballColor
        SETabSettings.current.tintColor = tintColor
        SETabSettings.current.unselectedItemTintColor = unselectedItemTintColor
        SETabSettings.current.barTintColor = barTintColor
        
        setBottomFillerViewColor()
        _tabBar?.applyColors()
        
    }
    
    // MARK: Setup TabBar and View Controllers
    
    private func setupViews() {
        
        _tabBar = animationType.tabView
        
        _tabBar.delegate = self
        view.addSubview(_tabBar)
        
        bottomFillerView = UIView()
        view.addSubview(bottomFillerView)
        setBottomFillerViewColor()
        
        createConstraints()
    }
    
    private func setBottomFillerViewColor() {
        bottomFillerView?.backgroundColor = SETabSettings.current.backgroundColor
    }
    
    private func createConstraints() {
        createTabBarConstraints()
        createBottomFillerViewConstraints()
    }
    
    private func createTabBarConstraints() {
        _tabBar.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(_tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(_tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(_tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(_tabBar.heightAnchor.constraint(equalToConstant: tabBarHeight))
        constraints.append(bottomFillerView.topAnchor.constraint(equalTo: _tabBar.bottomAnchor, constant: -10))
        
        // activate constraints
        constraints.forEach {
            $0.isActive = true
        }
    }
    
    private func createBottomFillerViewConstraints() {
        bottomFillerView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(bottomFillerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        constraints.append(bottomFillerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraints.append(bottomFillerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        
        // activate constraints
        constraints.forEach {
            $0.isActive = true
        }
    }
    
    private func setTabIcons() {
        _tabBar.tabImages = _viewControllers.map({ (viewController) -> UIImage in
            var tabItem: UITabBarItem?
            if let controller = (viewController as? UINavigationController)?.topViewController {
                if let seTabItemProvider = controller as? SETabItemProvider {
                    tabItem = seTabItemProvider.seTabBarItem
                }
                else {
                    tabItem = controller.tabBarItem
                }
            }
            else if let controller = viewController as? SETabItemProvider {
                tabItem = controller.seTabBarItem
            }
            else {
                tabItem = viewController.tabBarItem
            }
            return tabItem?.image ?? UIImage(named: "empty")!
        })
    }

    // MARK: - Actions
    private func moveToViewController(at index: Int) {
        
        guard index != self.lastSelectedTabIndex else {
            return
        }
        
        let currentView: UIView?
        
        if let lastSelectedTabIndex = lastSelectedTabIndex {
            currentView = _viewControllers[lastSelectedTabIndex].view
        }
        else {
            currentView = nil
        }
        
        currentView?.removeFromSuperview()
        
        let controller = self._viewControllers[index]
        let newView = controller.view
        if newView?.superview == nil {
            
            if isResetting {
                isResetting = false
                newView?.alpha = 0
                UIView.animate(withDuration: resetAnimationDuration) {
                    newView?.alpha = 1
                }
                
            }
            view.insertSubview(newView!, at: 0)
            controller.didMove(toParent: self)
            newView?.frame = view.bounds
        }
        
        lastSelectedTabIndex = index
        
    }
    
}

// MARK: - Changing animation

extension SETabViewController {
    private func resetAnimationType(indexToSelect: Int) {
        
        hideAndShowTabBar { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf._tabBar.removeFromSuperview()
            strongSelf._tabBar = strongSelf.animationType.tabView
            strongSelf._tabBar.delegate = strongSelf
            strongSelf._tabBar.isHidden = true
            strongSelf.view.addSubview(strongSelf._tabBar)
            strongSelf.createTabBarConstraints()
            strongSelf.setTabIcons()
            strongSelf.selectedIndex = indexToSelect
        }
        
        
    }
    
    private func hideAndShowTabBar(completionHandler: (() -> ())? = nil) {
        // TODO: Complete
        
        self._tabBar.isUserInteractionEnabled = false
        
        UIView.transition(with: view, duration: resetAnimationDuration, options: [.transitionCrossDissolve]) { [weak self] in
            self?.bottomFillerView.isHidden = true
            self?._tabBar.isHidden = true
        } completion: { [weak self] _ in
            completionHandler?()
            self?.showTabBar()
        }

    }
    
    private func showTabBar() {
        UIView.transition(with: view, duration: resetAnimationDuration, options: [.transitionCrossDissolve]) { [weak self] in
            self?.bottomFillerView.isHidden = false
            self?._tabBar.isHidden = false
        } completion: { [weak self] _ in
            self?._tabBar.isUserInteractionEnabled = true
        }
    }
    
}

// MARK: - AnimatedTabViewDelegate

extension SETabViewController: AnimatedTabViewDelegate {
    public func didSelectTab(at index: Int) {
        
        guard index >= 0 && index < _viewControllers.count else { return }
        
        self.selectedIndex = index
    }
    
    func changeBottomFillerViewColor() {
        setBottomFillerViewColor()
    }
}

// MARK: - Trait collection change

extension SETabViewController {
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        hideAndShowTabBar()
    }
}
