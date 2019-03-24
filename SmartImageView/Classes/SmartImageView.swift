//
//  SmartImageView.swift
//  SmartImageWidget
//
//  Created by Jose Manuel Solis Bulos on 3/23/19.
//  Copyright © 2019 manuelbulos. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

@available(iOS 11.0, *)
public class SmartImageView: UIImageView {

    /// The object that acts as the delegate for the smart image view
    @IBOutlet public weak var delegate: SmartImageViewDelegate?

    private lazy var request: VNDetectFaceRectanglesRequest = {
        return VNDetectFaceRectanglesRequest(completionHandler: { [weak self] (request, error) in
            DispatchQueue.main.async(execute: {
                self?.handleRequestCallback(request: request, error: error)
            })
        })
    }()

    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        sharedInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    public override init(image: UIImage?) {
        super.init(image: image)
        sharedInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    public convenience init(cgImage: CGImage) {
        self.init(image: UIImage(cgImage: cgImage))
        sharedInit()
    }

    private func sharedInit() {
        DispatchQueue.main.async {
            self.removeSubviews()
            self.contentMode = .scaleAspectFit
        }
    }

    /// If no image is passed, it uses the current image being displayed.
    /// Otherwise updates current image.
    /// Runs on background thread.
    public func searchForFaces(on image: UIImage? = nil) {
        if let image = image { self.image = image }
        guard let cgImage = self.image?.cgImage else { return }
        sharedInit()
        searchForFaces(on: cgImage)
    }

    private func searchForFaces(on cgImage: CGImage) {
        DispatchQueue.global(qos: .background).async {
            do {
                let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                try handler.perform([self.request])
            } catch {
                self.handleError(error)
            }
        }
    }

    private func removeSubviews() {
        self.subviews.forEach({$0.removeFromSuperview()})
    }

    private func handleError(_ error: Error) {
        DispatchQueue.main.async {
            self.delegate?.smartImageView?(self, encountered: error)
        }
    }

    private func handleRequestCallback(request: VNRequest, error: Error?) {
        if let error = error {
            handleError(error)
        } else {
            guard let results = request.results else { return }
            handleResults(results)
        }
    }

    private func handleResults(_ results: [Any]) {
        countNumberOfFacesFound(from: results)
        removeSubviews()
        for faceObservation in results {
            guard let faceObservation = faceObservation as? VNFaceObservation else { return }
            handleFaceObservation(faceObservation)
        }
    }

    private func countNumberOfFacesFound(from results: [Any]) {
        var numberOfFacesFound: Int = 0
        for faceObservation in results {
            guard (faceObservation as? VNFaceObservation) != nil else { return }
            numberOfFacesFound += 1
        }
        didFinishSearching(numberOfFacesFound: numberOfFacesFound)
    }

    private func handleFaceObservation(_ faceObservation: VNFaceObservation) {
        let frame = getFrameForBoundingBox(faceObservation.boundingBox)
        guard let view = delegate?.smartImageView?(self, viewForFaceIn: frame) else { return }
        insertSubview(view, aboveSubview: self)
    }

    private func getFrameForBoundingBox(_ boundingBox: CGRect) -> CGRect {
        layoutIfNeeded()
        guard let size = image?.size else { return .zero }
        let imageRect = AVMakeRect(aspectRatio: size, insideRect: bounds)
        let relativeWidth = imageRect.width * boundingBox.width
        let relativeHeight = imageRect.height * boundingBox.height
        let xCoordinate = (imageRect.width * boundingBox.origin.x) + imageRect.origin.x
        let yCoordinate = (imageRect.height * (1 - boundingBox.origin.y) - relativeHeight) + imageRect.origin.y
        return CGRect(x: xCoordinate, y: yCoordinate, width: relativeWidth, height: relativeHeight)
    }

    private func didFinishSearching(numberOfFacesFound: Int) {
        delegate?.smartImageView?(self, numberOfFacesFound: numberOfFacesFound)
    }

}
