//
//  FeedImageLoadView.swift
//  EssentialFeed
//
//  Created by Marcin Kapusta on 24/02/2025.
//  Copyright © 2025 Essential Developer. All rights reserved.
//

import UIKit

public final class FeedImageLoadView: UIView {
    public let imageView = UIImageView()
    
    private(set) public lazy var retryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var onRetry: (() -> Void)?
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
}
