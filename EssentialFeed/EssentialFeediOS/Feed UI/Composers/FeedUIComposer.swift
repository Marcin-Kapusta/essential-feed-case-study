//
//  FeedUIComposer.swift
//  EssentialFeed
//
//  Created by Marcin Kapusta on 24/02/2025.
//  Copyright © 2025 Essential Developer. All rights reserved.
//

import EssentialFeed

public final class FeedUIComposer {
    
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let refreshController = FeedRefreshViewController(feedLoader: feedLoader)
        let feedController = FeedViewController(refreshController: refreshController)
        refreshController.onRefresh = adaptFeedToCellControllers(forwardingTo: feedController, loader: imageLoader)
        return feedController
    }
    
    static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak controller] feed in
            controller?.tableModel = feed.map({ image in
                let imageController = FeedImageLoadController(imageURL: image.url, imageLoader: loader)
                return FeedImageCellController(model: image, imageController: imageController)
            })
        }
    }
}
