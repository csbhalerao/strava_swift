//
//  FeedTableViewCell.swift
//  strava_swift
//
//  Created by Chetan Bhalerao on 5/16/18.
//  Copyright © 2018 Chetan Bhalerao. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var feedDate: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var feedName: UILabel!
    @IBOutlet weak var distanceLable: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populateValues(feed:Feed){
        let distanceInKm = feed.distance/1000
        let timeInMin = feed.movingTime/60
        feedDate.text = feed.startDate
        feedName.text = feed.name
        distanceLable.text = String(distanceInKm.roundToDecimal(2))+" KM"
        timeLabel.text = String(timeInMin)+" Min"
        let pace = Double(timeInMin)/distanceInKm
        paceLabel.text = String(pace.roundToDecimal(2))+"/KM"
        
    }
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
