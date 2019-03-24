//
//  SmartImageViewDelegate.swift
//  SmartImageWidget
//
//  Created by Jose Manuel Solis Bulos on 3/23/19.
//  Copyright © 2019 manuelbulos. All rights reserved.
//

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
