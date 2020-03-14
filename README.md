[![CI Status](https://img.shields.io/travis/eshwavin/SETabView.svg?style=flat)](https://travis-ci.org/eshwavin/SETabView)
[![Version](https://img.shields.io/cocoapods/v/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)
[![License](https://img.shields.io/cocoapods/l/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)
[![Platform](https://img.shields.io/cocoapods/p/SETabView.svg?style=flat)](https://cocoapods.org/pods/SETabView)

## Animations

#### .holeBall1

<p align="center">
 <img src=""  >
</p>

#### .holeBall2

<p align="center">
 <img src=""  >
</p>

#### .holeBall3

<p align="center">
 <img src=""  >
</p>

## Requirements

SETabView is written is Swift 5 and is deployed for iOS 11.0 and above. 

## Integration

#### CocoaPods

SETabView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SETabView'
```

#### Directly include source files

Download and add the files in the [Source](https://github.com/eshwavin/SETabView/tree/master/Source) folder directly into your Xcode Project. In this case you should **skip** 

```
import SETabView
```

in the usage instructions.

## Usage

Import `VCTabView` into the View Controller and any child View Controllers

```
import SETabView
```

Inherit the `SEViewController` class in the parent ViewController
```
class ViewController: SEViewController {

   override func viewDidLoad() {
    super.viewDidLoad()

  }
}
```

In  `viewDidLoad` set the child View Controllers.

```
class ViewController: SEViewController {
    
    override func viewDidLoad() {
      super.viewDidLoad()
      // set the child View Controllers
      setTabsControllers()

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
The child View Controllers need to conform to the `SETabItem` protocol

```
class FirstViewController: UIViewController, SETabItem {

    var tabImage: UIImage? {
        return UIImage(named: "first")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

## Customization

Customise the appearance and animation type of the TabBar by overriding the `setTabSettings()` and `setAnimationType()` functions
```
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

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Srivinayak Chaitanya Eshwa, eshwavin@gmail.com

## License

SETabView is available under the MIT license. See the LICENSE file for more info.

## Acknowledgement

[Animation Inspiration](https://www.behance.net/gallery/79473185/25-Animated-Tab-Bar-Designs-for-Inspiration)

[Icons](https://www.flaticon.com/authors/nikita-golubev)
