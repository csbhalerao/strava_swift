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

class HomeViewController: UIViewController, HomePresenterView {
    var presenter: HomePresenter?
    var feeds = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view:self)
        presenter?.fetchMyFeeds(pageNumber: 1, perPage: 20)
    }
    
    func onSuccessfulFeedFetching(feeds: [Feed]) {
        self.feeds.append(contentsOf: feeds)
        print(self.feeds.count)
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
    }
    let name: String
    let distance:Double
    let movingTime:Int
    let totalElevationGain: Double
}
