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
import UIKit

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

## SmartImageViewDelegate
```swift
import UIKit

@available(iOS 11.0, *)
@objc public protocol SmartImageViewDelegate: class {

    /// Asks the delegate for a view object to display in every face found.
    @objc func smartImageView(_ smartImageView: SmartImageView, viewForFaceIn frame: CGRect) -> UIView

    /// Sent after SmartImageView finishes searching for faces.
    @objc optional func smartImageView(_ smartImageView: SmartImageView, numberOfFacesFound: Int)

    /// Sent if an error was found at any time during the task.
    @objc optional func smartImageView(_ smartImageView: SmartImageView, encountered error: Error)

}
```

## SmartImageViewDelegate Usage
```swift
extension ViewController: SmartImageViewDelegate {

    func smartImageView(_ smartImageView: SmartImageView, numberOfFacesFound: Int) {
        print("Found: \(numberOfFacesFound) face(s)")
    }

    func smartImageView(_ smartImageView: SmartImageView, viewForFaceIn frame: CGRect) -> UIView {
        let customView = UIView(frame: frame)
        customView.backgroundColor = .yellow
        customView.alpha = 0.5
        return customView
    }

    func smartImageView(_ smartImageView: SmartImageView, encountered error: Error) {
        print(error.localizedDescription)
    }

}
```

## Author

manuelbulos, manuelbulos@gmail.com

## License

SmartImageView is available under the MIT license. See the LICENSE file for more info.
