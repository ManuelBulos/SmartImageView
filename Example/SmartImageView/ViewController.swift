//
//  ViewController.swift
//  SmartImageView
//
//  Created by manuelbulos on 03/24/2019.
//  Copyright (c) 2019 manuelbulos. All rights reserved.
//

import UIKit
import SmartImageView

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var smartImageView: SmartImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var button: UIButton!

    lazy var images: [UIImage?] = {
        var images = [UIImage?]()
        for index in 1...5 { images.append(UIImage(named: "Sample\(index)")) }
        return images
    }()

    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        smartImageView.delegate = self
        smartImageView.searchForFaces(on: images[index])
    }

    @IBAction func nextImageButtonTapped(_ sender: UIButton) {
        index = index == images.count - 1 ? 0 : index + 1
        smartImageView.searchForFaces(on: images[index])
        toggleUI(text: "Searching")
    }

}

// MARK: - SmartImageViewDelegate

extension ViewController: SmartImageViewDelegate {

    // called when the face searching task has finished
    func smartImageView(_ smartImageView: SmartImageView, numberOfFacesFound: Int) {
        toggleUI(text: "Found: \(numberOfFacesFound) face(s)")
    }

    // called each time a new face is found in the image
    func smartImageView(_ smartImageView: SmartImageView, viewForFaceIn frame: CGRect) -> UIView {
        let customView = UIView(frame: frame)
        customView.backgroundColor = .yellow
        customView.alpha = 0.5
        return customView
    }

    // called only if an error was encountered at any time during the task.
    func smartImageView(_ smartImageView: SmartImageView, encountered error: Error) {
        label.text = error.localizedDescription
    }

}

// MARK: - UI

extension ViewController {

    func toggleUI(text: String) {
        activityIndicator.isAnimating ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
        button.isEnabled.toggle()
        label.text = text
    }

}

