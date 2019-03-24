# SmartImageView

[![CI Status](https://img.shields.io/travis/manuelbulos/SmartImageView.svg?style=flat)](https://travis-ci.org/manuelbulos/SmartImageView)
[![Version](https://img.shields.io/cocoapods/v/SmartImageView.svg?style=flat)](https://cocoapods.org/pods/SmartImageView)
[![License](https://img.shields.io/cocoapods/l/SmartImageView.svg?style=flat)](https://cocoapods.org/pods/SmartImageView)
[![Platform](https://img.shields.io/cocoapods/p/SmartImageView.svg?style=flat)](https://cocoapods.org/pods/SmartImageView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 11.0 *

## Installation

SmartImageView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SmartImageView'
```

## Usage
```swift
class ViewController: UIViewController {

    // Works programmatically or using the interface builder
    @IBOutlet weak var smartImageView: SmartImageView!
    
    fileprivate let image = UIImage(named: "Sample1")

    override func viewDidLoad() {
        super.viewDidLoad()
        smartImageView.delegate = self
        smartImageView.searchForFaces(on: image)
    }
}
```

## Author

manuelbulos, manuelbulos@gmail.com

## License

SmartImageView is available under the MIT license. See the LICENSE file for more info.
