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
    func showProgress()
    func hideProgress()
}

class HomeViewController: UIViewController, HomePresenterView, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var feedsTableView: UITableView!
    
    var presenter: HomePresenter?
    var feeds = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedsTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        presenter = HomePresenter(view:self)
        presenter?.fetchMyFeeds(pageNumber: 1, perPage: 20)
        self.feedsTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = self.feeds[indexPath.row]
        let cell = feedsTableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        cell.populateValues(feed: feed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = self.feeds[indexPath.row]
        let feedDetailViewController = FeedDetailViewController()
        feedDetailViewController.feed = feed
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
        
    }
    
    func onSuccessfulFeedFetching(feeds: [Feed]) {
        self.feeds.append(contentsOf: feeds)
        self.feedsTableView.reloadData()
    }
    
    func onFeedApiFailure(error: String) {
        //todo add alert
    }
    
    func showProgress() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimating()
    }
    
    func hideProgress() {
        progressIndicator.isHidden = true
        progressIndicator.stopAnimating()
    }
}



struct Feed :Decodable{
    enum CodingKeys: String, CodingKey{
        case movingTime = "moving_time"
        case totalElevationGain = "total_elevation_gain"
        case name = "name"
        case distance = "distance"
        case startDate = "start_date"
        case feedMap = "map"
        case startLatlng = "start_latlng"
        case endLatlng = "end_latlng"
    }
    let name: String
    let distance:Double
    let movingTime:Int
    let totalElevationGain: Double
    let startDate: String
    let feedMap: FeedMap
    let startLatlng: [Double]
    let endLatlng: [Double]
}

struct FeedMap:Decodable {
    enum CodingKeys: String, CodingKey {
        case summaryPolyline = "summary_polyline"
    }
    let summaryPolyline:String?
}
