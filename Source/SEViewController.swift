//
//  ViewController.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 15/02/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

open class SEViewController: UIViewController {
    
    // MARK: Properties: TabBar
    private var lastSelectedTabIndex: Int?
    
    public var selectedTabIndex: Int {
        get {
            return self.tabBar.selectedTabIndex
        }
        set {
            
            if self.viewControllers == nil {
                fatalError("Cannot select a tab before setting view controllers")
            }
            
            self.tabBar.closureAfterSetup = { [weak self] in
                self?.tabBar.selectedTabIndex = newValue
                self?.moveToViewController(at: newValue)
            }
            if (self.tabBar.setup) {
                self.tabBar.selectedTabIndex = newValue
                self.moveToViewController(at: newValue)
            }
            
        }
    }
    
    // MARK: Properties: Views/View Controllers
    private var tabBar: SETabView!
    private var containerView: UIView! // view to contain the views of ViewControllers
    private var bottomFillerView: UIView! // view to fill the space between home control and safe area
    /// specifies the animation type
    public var animationType: AnimationTypes? {
        willSet {
            if animationType != nil {
                fatalError("Cannot change tab bar animation once set")
            }
            if self.viewControllers == nil {
                fatalError("Set viewControllers property before setting animationType")
            }
        }
        didSet {
            self.tabBar.animationType = self.animationType!
        }
    }
    
    public var viewControllers: [UIViewController]? = nil {
        willSet {
            if viewControllers != nil {
                fatalError("View Controllers cannot be set multiple times")
            }
        }
        didSet {
            if viewControllers!.count > 5 {
                fatalError("Cannot handle more than 5 tabs as of now")
            }
            else {
                viewControllers?.forEach(addChild(_:))
                self.setupViews()
                self.setTabIcons()
                self.setAnimationType()
                self.selectedTabIndex = 0
                
            }
        }
    }
    
    // MARK: Functions: LifeCycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.setTabSettings()
    }
    
    // MARK: Setup TabBar and View Controllers
    
    /// modifies the look of the VCTabBar
    open func setTabSettings() {
        SETabView.settings.tabColor = UIColor.white
        SETabView.settings.ballColor = UIColor.white
        SETabView.settings.selectedTabTintColor = UIColor.black
        SETabView.settings.unselectedTabTintColor = UIColor.gray
        SETabView.settings.animationDuration = 1
    }
    
    /// sets the type of animation of the VCTabBar
    open func setAnimationType() {
        self.animationType = .holeBall3
    }
    
    private func setupViews() {
        self.containerView = UIView()
        self.view.addSubview(self.containerView)
        
        self.tabBar = SETabView()
        self.tabBar.delegate = self
        self.view.addSubview(self.tabBar)
        
        self.bottomFillerView = UIView()
        self.bottomFillerView.backgroundColor = SETabView.settings.tabColor
        self.view.addSubview(self.bottomFillerView)
        
        self.createConstraints()
    }
    
    private func createConstraints() {
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.tabBar.translatesAutoresizingMaskIntoConstraints = false
        self.bottomFillerView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        
        // containter view constraints
        if #available(iOS 11.0, *) {
            constraints.append(self.containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor))
        }
        else {
            constraints.append(self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        }
        constraints.append(self.containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        constraints.append(self.containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraints.append(self.containerView.topAnchor.constraint(equalTo: self.view.topAnchor))
        
        // tabBar constraints
        if #available(iOS 11.0, *) {
            constraints.append(self.tabBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor))
        }
        else {
            constraints.append(self.tabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        }
        constraints.append(self.tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        constraints.append(self.tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraints.append(self.tabBar.heightAnchor.constraint(equalToConstant: 60))
        
        // bottom filler view constraints
        constraints.append(self.bottomFillerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        constraints.append(self.bottomFillerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraints.append(self.bottomFillerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        constraints.append(self.bottomFillerView.topAnchor.constraint(equalTo: self.tabBar.bottomAnchor))
        
        // activate constraints
        constraints.forEach {
            $0.isActive = true
        }
    }
    
    private func setTabIcons() {
        
        self.tabBar.tabImages = self.children.compactMap({ (viewController) -> UIImage? in
            var tabItem: SETabItem!
            if let controller = (viewController as? UINavigationController)?.topViewController as? SETabItem {
                tabItem = controller
            }
            else if let controller = viewController as? SETabItem {
                tabItem = controller
            }
            else {
                fatalError("View Controller must implement VCTabItem Protocol")
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
        
        self.lastSelectedTabIndex = index
        
    }
    
}

extension SEViewController: SETabViewDelegate {
    public func didSelectTab(at index: Int) {
        self.selectedTabIndex = index
    }
}
