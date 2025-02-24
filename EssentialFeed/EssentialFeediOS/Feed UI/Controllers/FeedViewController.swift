//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {
    private var refreshController: FeedRefreshViewController?
    var tableModel = [FeedImageCellController]() {
        didSet { tableView.reloadData() }
    }

	convenience init(refreshController: FeedRefreshViewController) {
		self.init()
        self.refreshController = refreshController
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
        refreshControl = refreshController?.view
        
		tableView.prefetchDataSource = self
        refreshController?.refresh()
	}
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
	
	public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableModel.count
	}
	
	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view()
	}
	
	public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelImageControllerLoad(forRowAt: indexPath)
	}
	
	public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach { indexPath in
            imageLoadController(forRowAt: indexPath).preload()
		}
	}
	
	public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach(cancelImageControllerLoad)
	}
    
    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
        return tableModel[indexPath.row]
    }
    
    private func imageLoadController(forRowAt indexPath: IndexPath) -> FeedImageLoadController {
        return cellController(forRowAt: indexPath).imageLoadController
    }
    
	private func cancelImageControllerLoad(forRowAt indexPath: IndexPath) {
        imageLoadController(forRowAt: indexPath).cancelLoad()
	}
}
