//
//  SEViewController.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 15/02/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

open class SETabViewController: UIViewController, AnimatedTabViewProperties {
    
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
            setBottomFillerViewColor()
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
    
    public var animationDuration: Double {
        set {
            SETabSettings.current.animationDuration = newValue
        }
        get {
            return SETabSettings.current.animationDuration
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
            
            guard let viewControllers = viewControllers,
                  selectedIndex < viewControllers.count && selectedIndex > -1 else {
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
    private var _tabBar: AnimatedTabView!
    public var tabBar: AnimatedTabViewProperties {
        return self as AnimatedTabViewProperties
    }
    private var bottomFillerView: UIView! // view to fill the space between home control and safe area
    public var animationType: AnimationType = .holeBall1 {
        didSet {
            guard viewControllers?.count ?? 0 > 0, animationType != oldValue else { return }
            resetAnimationType()
        }
    }
    
    private(set) var viewControllers: [UIViewController]? = nil {
        willSet {
            if viewControllers != nil {
                fatalError("View Controllers cannot be set multiple times")
            }
        }
        didSet {
            viewControllers?.forEach(addChild(_:))
            viewControllers?.forEach {
                $0.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight, right: 0)
            }
            self.setupViews()
            self.setTabIcons()
        }
    }
    
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
        
        guard viewControllers.count > 0 else {
            return
        }
        
        guard viewControllers.count < 6 else {
            fatalError("SETabViewController Cannot handle more than 5 tabs as of now")
        }
        
        self.viewControllers = viewControllers
        selectedIndex = _tabBar.selectedTabIndex
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
        _tabBar.tabImages = children.compactMap({ (viewController) -> UIImage? in
            var tabItem: SETabItemProvider
            if let controller = (viewController as? UINavigationController)?.topViewController {
                if let seTabItemProvider = controller as? SETabItemProvider {
                    tabItem = seTabItemProvider
                }
                else {
                    return controller.tabBarItem.image ?? UIImage(named: "empty")!
                }
            }
            else if let controller = viewController as? SETabItemProvider {
                tabItem = controller
            }
            else {
                return viewController.tabBarItem.image ?? UIImage(named: "empty")!
            }
            return tabItem.seTabBarItem
        })
    }

    // MARK: - Actions
    private func moveToViewController(at index: Int) {
        
        guard index != self.lastSelectedTabIndex, let viewControllers = viewControllers else {
            return
        }
        
        let currentView: UIView?
        
        if let lastSelectedTabIndex = lastSelectedTabIndex {
            currentView = viewControllers[lastSelectedTabIndex].view
        }
        else {
            currentView = nil
        }
        
        currentView?.removeFromSuperview()
        
        let controller = self.children[index]
        let newView = controller.view
        if newView?.superview == nil {
            view.insertSubview(newView!, at: 0)
            controller.didMove(toParent: self)
            newView?.frame = view.bounds
        }
        
        lastSelectedTabIndex = index
        
    }
    
}

// MARK: - Changing animation

extension SETabViewController {
    private func resetAnimationType() {
        
        hideTabBar { [weak self] in
            guard let strongSelf = self else { return }
            let oldSelectedIndex = strongSelf._tabBar.selectedTabIndex
            strongSelf._tabBar.removeFromSuperview()
            strongSelf._tabBar = strongSelf.animationType.tabView
            strongSelf._tabBar.delegate = strongSelf
            strongSelf._tabBar.isHidden = true
            strongSelf.view.addSubview(strongSelf._tabBar)
            strongSelf.createTabBarConstraints()
            strongSelf.setTabIcons()
            strongSelf.selectedIndex = oldSelectedIndex
        }
        
        
    }
    
    private func hideTabBar(completionHandler: (() -> ())? = nil) {
        // TODO: Complete
        
        self._tabBar.isUserInteractionEnabled = false
        
        UIView.transition(with: view, duration: 0.5, options: [.transitionCrossDissolve]) { [weak self] in
            self?.bottomFillerView.isHidden = true
            self?._tabBar.isHidden = true
        } completion: { [weak self] _ in
            completionHandler?()
            self?.showTabBar()
        }

    }
    
    private func showTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            UIView.transition(with: strongSelf.view, duration: 0.5, options: [.transitionCrossDissolve]) { [weak self] in
                self?.bottomFillerView.isHidden = false
                self?._tabBar.isHidden = false
            } completion: { [weak self] _ in
                self?._tabBar.isUserInteractionEnabled = true
            }
        }
    }
    
}

// MARK: - AnimatedTabViewDelegate

extension SETabViewController: AnimatedTabViewDelegate {
    public func didSelectTab(at index: Int) {
        
        guard let viewControllers = viewControllers,
            index >= 0 && index < viewControllers.count else { return }
        
        self.selectedIndex = index
    }
}

// MARK: - Trait collection change

extension SETabViewController {
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        hideTabBar()
    }
}
