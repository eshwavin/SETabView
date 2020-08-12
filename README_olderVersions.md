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

In case the latest version (0.3.0) is not the one being installed, update the pod.

```
pod update 'SETabView'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding SETabView as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
.package(url: "https://github.com/eshwavin/SETabView.git", .upToNextMajor(from: "0.3.0"))
]
```

### Directly include source files

Download and add the files in the [Source](https://github.com/eshwavin/SETabView/tree/master/Source) folder directly into your Xcode Project. In this case you should **skip** 

```swift
import SETabView
```

in the usage instructions.

## Usage

Import `VCTabView` into the parent ViewController and any child View Controllers

```swift
import SETabView
```

Inherit the `SEViewController` class in the parent ViewController
```swift
class ViewController: SEViewController {

   override func viewDidLoad() {
    super.viewDidLoad()

  }
}
```

In  `viewDidLoad` of the parent ViewController, set the child ViewControllers.

```swift
class ViewController: SEViewController {
    
    override func viewDidLoad() {
      super.viewDidLoad()
      // set the child View Controllers
      setViewControllers()

    }

    private func setViewControllers() {
        
        // instantiate the child View Controllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstVC = storyboard.instantiateViewController(withIdentifier: "firstVC")
        let secondVC = storyboard.instantiateViewController(withIdentifier: "secondVC")
        let thirdVC = storyboard.instantiateViewController(withIdentifier: "thirdVC")
        let fourthVC = storyboard.instantiateViewController(withIdentifier: "fourthVC")
        
        // assign the child View Controllers
        self.viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
        
    }
   
}
```
The child ViewControllers need to conform to the `SETabItem` protocol

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

## Customization

Customise the appearance and animation type of the TabBar by overriding the `setTabSettings()` and `setAnimationType()` functions in the parent ViewController
```swift
override func setTabSettings() {

    // customise tab bar appearance
    SETabView.settings.tabColor = UIColor.black
    SETabView.settings.ballColor = UIColor.black
    SETabView.settings.selectedTabTintColor = UIColor.white
    SETabView.settings.unselectedTabTintColor = UIColor.gray
    
    // customise animation duration
    SETabView.settings.animationDuration = 1.5 // optimal duration = 1.5
}

override func setAnimationType() {
    self.animationType = .holeBall3 // defaults to .holeBall3
}
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
