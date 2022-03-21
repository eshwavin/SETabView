[![CI Status](https://img.shields.io/travis/eshwavin/SETabView.svg?style=flat)](https://travis-ci.org/eshwavin/SETabView)
[![Version](https://img.shields.io/cocoapods/v/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)
[![License](https://img.shields.io/cocoapods/l/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)
[![Platform](https://img.shields.io/cocoapods/p/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)

## Animations

.holeBall1 | .holeBall2 | .holeBall3
---------| --------------|---------|
<img src="https://github.com/eshwavin/SETabView/blob/master/Gifs/HoleBall1.gif"> | <img src="https://github.com/eshwavin/SETabView/blob/master/Gifs/HoleBall2.gif"> | <img src="https://github.com/eshwavin/SETabView/blob/master/Gifs/HoleBall3.gif">

## What's New?

#### The API has been changed to resemble `UITabBarController`
- Colors have been renamed to conform to colors specified by `UITabBar`
- Colors can be set collectively as before (function parameter names have been changed to reflect the changed color names) or individually
- Colors can now be changed at any point in time
- The view controllers at any time
- The animation type can be changed at any time to switch between available animations by setting the `animationType` property!
- `animationDuration` can no longer be changed

#### Bug fixes
- A bug that caused holeBall3 to behave weirdly in larger screen sizes has been squashed
- Glitchy landscape mode behaviour has been fixed

A whole lot of performance optimizations have been added so that our library does not slow down your app. Hurray!

## Requirements

- Swift 5+
- iOS 11.0+
- Swift tools version 5.0+ (For Swift Package Manager)

## Integration

### CocoaPods

SETabView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SETabView'
```

In case the latest version (2.0.0) is not the one being installed, update the pod.

```
pod update 'SETabView'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding SETabView as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
.package(url: "https://github.com/eshwavin/SETabView.git", .upToNextMajor(from: "2.0.0"))
]
```

### Directly include source files

Download and add the files in the [Source](https://github.com/eshwavin/SETabView/tree/master/Source) folder directly into your Xcode Project. In this case you should **skip** 

```swift
import SETabView
```

in the usage instructions.

## Usage and Customization

Import `SETabView` into the parent view controller and any child view controllers

```swift
import SETabView
```

Inherit from the `SETabViewController` class in your tab view controller
```swift
class MyCustomTabViewController: SETabViewController {

   override func viewDidLoad() {
    super.viewDidLoad()

  }
}
```

### Setting the view controllers and colors

Set the view controllers using `setViewControllers(_:)` method or by directly setting the `viewControllers` property 

Customise the look by calling `setTabColors(backgroundColor:ballColor:tintColor:unselectedItemTintColor:barTintColor:)` method or simply setting the respective colors


```swift
class ViewController: SEViewController {
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      // set tab bar look collectively
      setTabColors(backgroundColor: UIColor.white, ballColor: UIColor.white, tintColor: UIColor.black, unselectedItemTintColor: UIColor.red, barTintColor: .clear)
      
      // set the view controllers
      setViewControllers(getViewControllers(), initialSelectedTabIndex: 0, animationType: .holeBall3)

    }

    private func getViewControllers() -> [UIViewController] {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return [
            storyboard.instantiateViewController(withIdentifier: "firstVC"),
            storyboard.instantiateViewController(withIdentifier: "secondVC"),
            storyboard.instantiateViewController(withIdentifier: "thirdVC"),
            storyboard.instantiateViewController(withIdentifier: "fourthVC"),
            storyboard.instantiateViewController(withIdentifier: "fifthVC")
        ]
    }   
}
```

### Providing the image for the tab bar

The child view controllers can conform to the `SETabItemProvider` protocol. Using `seTabImage` return a `UITabBarItem` for the view controller.


Alternatively you can set the `tabBarItem` property for the view controllers as you would do when using `UITabBarController`

```swift
class FirstViewController: UIViewController, SETabItemProvider {

    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: UIImage(named: "first"), tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

### Setting the selected index programmatically

```swift
selectedTabIndex = 3
```

## Restrictions

- Max 5 Tabs

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Planned Improvements

- More `UITabBarController` behaviours
- Increasing support for number of tabs by introducing a **More** tab
- Badges
- Performance improvements

## Author

Srivinayak Chaitanya Eshwa, eshwavin@gmail.com

## License

SETabView is available under the MIT license. See the LICENSE file for more info.
SETabView uses the complete OrderedCollections code from [swift-collections](https://github.com/apple/swift-collections)

## Acknowledgement

[Animation Inspiration](https://www.behance.net/gallery/79473185/25-Animated-Tab-Bar-Designs-for-Inspiration)

[Icons](https://www.flaticon.com/authors/nikita-golubev)
