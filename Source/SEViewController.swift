//
//  SEViewController.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 15/02/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

open class SEViewController: UIViewController {
    
    // MARK: Properties: TabBar
    private var lastSelectedTabIndex: Int?
    /// the index of the view controller associated with the currently selected tab item
    public var selectedTabIndex: Int {
        get {
            return tabBar.selectedTabIndex
        }
        set {
            guard let viewControllers = viewControllers, newValue < viewControllers.count else {
                fatalError("Selected index out of bounds")
            }
            
            self.tabBar.closureAfterSetup = { [weak self] in
                self?.tabBar.selectedTabIndex = newValue
                self?.moveToViewController(at: newValue)
            }
            if (self.tabBar.isSetup) {
                self.tabBar.selectedTabIndex = newValue
                self.moveToViewController(at: newValue)
            }
            
        }
    }
    
    // MARK: Properties: Views/View Controllers
    private var tabBar: AnimatedTabView!
    private var containerView: UIView! // view to contain the views of ViewControllers
    private var bottomFillerView: UIView! // view to fill the space between home control and safe area
    private var animationType: AnimationType = .holeBall1 // animation type
    
    private var viewControllers: [UIViewController]? = nil {
        willSet {
            if viewControllers != nil {
                fatalError("View Controllers cannot be set multiple times")
            }
        }
        didSet {
            if viewControllers!.count > 5 {
                fatalError("Cannot handle more than 5 tabs as of now")
            } else if viewControllers!.count == 0 {
                fatalError("Must have at least one View Controller embedded in TabBar")
            } else {
                viewControllers?.forEach(addChild(_:))
                self.setupViews()
                self.setTabIcons()
                
            }
        }
    }
    
    // MARK: Functions: LifeCycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Setup
    
    /// Setup the TabBar along with animation behaviour
    /// - Parameters:
    ///   - viewControllers: The embedded view controllers of the tab bar
    ///   - initialSelectedTabIndex: The initial view controller to display on loading app, default value is 0
    ///   - animationType: The type of animation of the tab bar, default value is holeBall1
    public func setViewControllers(_ viewControllers: [UIViewController], initialSelectedTabIndex: Int = 0, animationType: AnimationType = .holeBall1) {
        
        guard initialSelectedTabIndex < viewControllers.count else {
            fatalError("initialSelectedIndex out of bounds")
        }
        
        self.animationType = animationType
        self.viewControllers = viewControllers
        self.selectedTabIndex = initialSelectedTabIndex
    }
    
    /// Change the default look and animation duration of the SETabView
    /// - Parameters:
    ///   - tabColor: The color of the tab bar. Default value is UIColor.black
    ///   - ballColor: The color of the ball. Default value is UIColor.black
    ///   - selectedTabTintColor: The tint of the tab item when selected. Default value is UIColor.white
    ///   - deselectedTabTintColor: The tint of the tab item when selected. Default value is UIColor.gray
    ///   - animationDuration: The duration of the entire tab switching animation. Default value is 1.5
    public func setTabSettings(tabColor: UIColor, ballColor: UIColor, selectedTabTintColor: UIColor, deselectedTabTintColor: UIColor, animationDuration: Double) {
        
        guard viewControllers == nil else {
            print("Please set settings before setting view controllers. Changes made afterwards will not be applied")
            return
        }
        
        SETabSettings.current.tabColor = tabColor
        SETabSettings.current.ballColor = ballColor
        SETabSettings.current.selectedTabTintColor = selectedTabTintColor
        SETabSettings.current.deselectedTabTintColor = deselectedTabTintColor
        SETabSettings.current.animationDuration = animationDuration
    }
    
    // MARK: Setup TabBar and View Controllers
    
    private func setupViews() {
        containerView = UIView()
        view.addSubview(containerView)
        
        tabBar = animationType.tabView
        
        tabBar.delegate = self
        view.addSubview(tabBar)
        
        bottomFillerView = UIView()
        bottomFillerView.backgroundColor = SETabSettings.current.tabColor
        view.addSubview(bottomFillerView)
        
        createConstraints()
    }
    
    private func createConstraints() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        bottomFillerView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        
        // container view constraints
        constraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(containerView.topAnchor.constraint(equalTo: view.topAnchor))
        
        // tabBar constraints
        constraints.append(tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tabBar.heightAnchor.constraint(equalToConstant: 60))
        
        // bottom filler view constraints
        constraints.append(bottomFillerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        constraints.append(bottomFillerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraints.append(bottomFillerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        constraints.append(bottomFillerView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -10))
        
        // activate constraints
        constraints.forEach {
            $0.isActive = true
        }
    }
    
    private func setTabIcons() {
        
        tabBar.tabImages = children.compactMap({ (viewController) -> UIImage? in
            var tabItem: SETabItem!
            if let controller = (viewController as? UINavigationController)?.topViewController as? SETabItem {
                tabItem = controller
            }
            else if let controller = viewController as? SETabItem {
                tabItem = controller
            }
            else {
                fatalError("View Controller must implement SETabItem Protocol")
            }
            return tabItem.tabImage
        })
        
        
    }

    // MARK: Actions
    private func moveToViewController(at index: Int) {
        
        guard index != self.lastSelectedTabIndex else {
            return
        }
        
        let currentView = self.containerView.subviews.first
        currentView?.removeFromSuperview()
        
        let controller = self.children[index]
        let newView = controller.view
        if newView?.superview == nil {
            self.containerView.addSubview(newView!)
            controller.didMove(toParent: self)
            newView?.frame = self.containerView.bounds
        }
        
        lastSelectedTabIndex = index
        
    }
    
}

extension SEViewController: SETabViewDelegate {
    public func didSelectTab(at index: Int) {
        
        guard let viewControllers = viewControllers,
            index >= 0 && index < viewControllers.count else { return }
        
        self.selectedTabIndex = index
    }
}
