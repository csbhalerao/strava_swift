//
//  HomeViewController.swift
//  strava_swift
//
//  Created by Chetan Bhalerao on 5/14/18.
//  Copyright © 2018 Chetan Bhalerao. All rights reserved.
//

import UIKit

protocol HomePresenterView : class {
    func onSuccessfulFeedFetching(feeds: [Feed])
    func onFeedApiFailure(error: String)
}

class HomeViewController: UIViewController, HomePresenterView, UITableViewDataSource, UITableViewDelegate {
    var presenter: HomePresenter?
    var feeds = [Feed]()

    @IBOutlet weak var feedsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view:self)
        presenter?.fetchMyFeeds(pageNumber: 1, perPage: 20)
        self.feedsTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = self.feeds[indexPath.row]
        let cell = feedsTableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        cell.populateValues(feed: feed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }
    func onSuccessfulFeedFetching(feeds: [Feed]) {
        self.feeds.append(contentsOf: feeds)
        print(self.feeds.count)
        self.feedsTableView.reloadData()
    }
    
    func onFeedApiFailure(error: String) {
        
    }
    
}



struct Feed :Decodable{
    enum CodingKeys: String, CodingKey{
        case movingTime = "moving_time"
        case totalElevationGain = "total_elevation_gain"
        case name = "name"
        case distance = "distance"
        case startDate = "start_date"
    }
    let name: String
    let distance:Double
    let movingTime:Int
    let totalElevationGain: Double
    let startDate: String
}
