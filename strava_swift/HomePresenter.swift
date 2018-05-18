//
//  HomePresenter.swift
//  strava_swift
//
//  Created by Chetan Bhalerao on 5/14/18.
//  Copyright © 2018 Chetan Bhalerao. All rights reserved.
//

import Foundation
import Alamofire

//protocol HomePresenterView : class {
//    func onSuccessfulFeedFetching(feeds: [Feed])
//    func onFeedApiFailure(error: String)
//}

class HomePresenter{
    let token: String = "d1cc9d1cf24a2018d010ea9d21587a901d12190c"
    let view: HomePresenterView?

    init(view: HomePresenterView) {
        self.view = view
    }
    
    func fetchMyFeeds(pageNumber: Int, perPage: Int){
        let url = URL(string: "https://www.strava.com/api/v3/athlete/activities?page=" + String(pageNumber)+"&per_page="+String(perPage))
        let headers = ["authorization" : "Bearer " + token]
        Alamofire.request(url!, method: .get, headers: headers).responseJSON { (response) in
            //            print(response.result)
            if response.result .isSuccess{
                if let data = response.data {
                    do{
                        var feeds = [Feed]()
                        feeds = try JSONDecoder().decode([Feed].self, from: data)
                        self.view?.onSuccessfulFeedFetching(feeds: feeds)
                    } catch {
                        print("Error occured while parsing")
                        self.view?.onFeedApiFailure(error: "Error occured while parsing")
                    }
                }
            }
            
            if response.result.isFailure {
                if let apiError = response.result.error?.localizedDescription{
                    self.view?.onFeedApiFailure(error: apiError)
                    print("Error occured..")
                } else {
                    self.view?.onFeedApiFailure(error: "Error else")
                }
            }
        }
    }
    
    func getAtheletInformation(){
        let url = URL(string: "https://www.strava.com/api/v3/athletes/12474362")
        let headers = ["authorization" : "Bearer " + token]
        Alamofire.request(url!, method: .get, headers: headers).responseJSON { (response) in
            if response.result .isSuccess{
    
                if let data = response.data {
                       let dataString = String(data: data, encoding: .utf8)
                    print(dataString)
                }
            }
                
        }
    }
}
