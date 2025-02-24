//
//  FeedImageLoadController.swift
//  EssentialFeed
//
//  Created by Marcin Kapusta on 24/02/2025.
//  Copyright © 2025 Essential Developer. All rights reserved.
//

import UIKit

final class FeedImageLoadController {
    private var loadingTask: FeedImageDataLoaderTask?
    private let imageURL: URL
    private let imageLoader: FeedImageDataLoader
    
    init(imageURL: URL, imageLoader: FeedImageDataLoader) {
        self.imageURL = imageURL
        self.imageLoader = imageLoader
    }
    
    func view() -> FeedImageLoadView {
        let view = FeedImageLoadView()
        view.imageView.image = nil
        view.retryButton.isHidden = true
        view.isShimmering = true
        let loadImage = { [weak self, weak view] in
            guard let self = self else { return }
            self.loadingTask = self.imageLoader.loadImageData(from: self.imageURL) { [weak view] result in
                let data = try? result.get()
                let image = data.map(UIImage.init) ?? nil
                view?.imageView.image = image
                view?.retryButton.isHidden = (image != nil)
                view?.isShimmering = false
            }
        }
        view.onRetry = loadImage
        loadImage()
        return view
    }
    
    func preload() {
        loadingTask = imageLoader.loadImageData(from: imageURL, completion: { _ in })
    }
    
    func cancelLoad() {
        loadingTask?.cancel()
        loadingTask = nil
    }
}
