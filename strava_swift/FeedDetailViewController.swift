//
//  FeedDetailViewController.swift
//  strava_swift
//
//  Created by Chetan Bhalerao on 5/21/18.
//  Copyright © 2018 Chetan Bhalerao. All rights reserved.
//

import UIKit
import GoogleMaps

class FeedDetailViewController: UIViewController {
    var feed: Feed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: (feed?.startLatlng[0])!, longitude: (feed?.startLatlng[1])!, zoom: 14.0)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        if let path = GMSPath(fromEncodedPath: (self.feed?.feedMap.summaryPolyline)!){
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 3.0
            polyline.strokeColor = UIColor.red
            let bounds = GMSCoordinateBounds(path: path)
            mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 10.0))
            mapView.animate(toZoom: 14.0)
            polyline.map = mapView
            let count = path.count()
            for index in 1...path.count() {
                print(index)
                if index == 1 || index == (count - 1){
                    let marker = GMSMarker()
                    let coOrdinate =  path.coordinate(at: index)
                    marker.position = CLLocationCoordinate2D(latitude: coOrdinate.latitude, longitude: coOrdinate.longitude)
                    if index == 1 {
                        marker.title = "Start Point"
                        marker.snippet = "Start Point"
                        marker.icon = GMSMarker.markerImage(with: UIColor.green)
                    } else {
                        marker.title = "End Point"
                        marker.snippet = "End Point"
                        marker.icon = GMSMarker.markerImage(with: UIColor.blue)
                    }
                    marker.map = mapView
                }
            }
        }
        
        self.view = mapView
    }
    
}
