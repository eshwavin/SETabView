[![CI Status](https://img.shields.io/travis/eshwavin/SETabView.svg?style=flat)](https://travis-ci.org/eshwavin/SETabView)
[![Version](https://img.shields.io/cocoapods/v/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)
[![License](https://img.shields.io/cocoapods/l/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)
[![Platform](https://img.shields.io/cocoapods/p/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)

## Animations

.holeBall1 | .holeBall2 | .holeBall3
---------| --------------|---------|
<img src="https://github.com/eshwavin/SETabView/blob/master/Gifs/HoleBall1.gif"> | <img src="https://github.com/eshwavin/SETabView/blob/master/Gifs/HoleBall2.gif"> | <img src="https://github.com/eshwavin/SETabView/blob/master/Gifs/HoleBall3.gif">

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

In case the latest version (1.1.1) is not the one being installed, update the pod.

```
pod update 'SETabView'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding SETabView as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
.package(url: "https://github.com/eshwavin/SETabView.git", .upToNextMajor(from: "1.1.1"))
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

Inherit the `SEViewController` class in the parent view controller
```swift
class ViewController: SEViewController {

   override func viewDidLoad() {
    super.viewDidLoad()

  }
}
```

In  `viewDidLoad` of the parent view controller, customise your tab bar look and set the child view controllers. 

Set the view controllers using `setViewControllers(_ viewControllers: [UIViewController], initialSelectedTabIndex: Int, animationType: AnimationType)` method.

Customise the look by calling `setTabSettings(tabColor: UIColor, ballColor: UIColor, selectedTabTintColor: UIColor, deselectedTabTintColor: UIColor, animationDuration: Double)` method.

**Make sure to call `setTabSettings` *before* setting your view controllers for the customisation to apply**

```swift
class ViewController: SEViewController {
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      // set tab bar look
      setTabSettings(tabColor: UIColor.black, ballColor: UIColor.black, selectedTabTintColor: UIColor.white, deselectedTabTintColor: UIColor.gray, animationDuration: 1)
      
      // set the viwe controllers
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
The child view controllers need to conform to the `SETabItem` protocol. Using `tabImage` return the image you want as the icon for the tab for that view controller.

```swift
class FirstViewController: UIViewController, SETabItem {

    var tabImage: UIImage? {
        return UIImage(named: "first")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

The selected tab can be changed programmatically

```swift
self.selectedTabIndex = 3
```

## Restrictions

- Max 5 Tabs
- Tab Bar look cannot be changed once set in `setTabSettings()`

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Srivinayak Chaitanya Eshwa, eshwavin@gmail.com

## License

SETabView is available under the MIT license. See the LICENSE file for more info.

## Acknowledgement

[Animation Inspiration](https://www.behance.net/gallery/79473185/25-Animated-Tab-Bar-Designs-for-Inspiration)

[Icons](https://www.flaticon.com/authors/nikita-golubev)
