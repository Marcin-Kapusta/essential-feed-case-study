//
//  FeedImageCellController.swift
//  EssentialFeed
//
//  Created by Marcin Kapusta on 24/02/2025.
//  Copyright © 2025 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed

final class FeedImageCellController {
    private let model: FeedImage
    private(set) var imageLoadController: FeedImageLoadController
    
    init(model: FeedImage, imageLoadController: FeedImageLoadController) {
        self.model = model
        self.imageLoadController = imageLoadController
    }
    
    func view() -> UITableViewCell {
        let cell = FeedImageCell()
        cell.locationContainer.isHidden = (model.location == nil)
        cell.locationLabel.text = model.location
        cell.descriptionLabel.text = model.description
        cell.imageLoadView = imageLoadController.view()
        return cell
    }
}
