//
//  GPS_View_Controller.swift
//  HSFlashBack
//
//  Created by Matthew King on 11/10/15.
//  Copyright © 2015 Matthew King. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class GPS_Page: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var lat: Double!
    var lon: Double!
    
    
    var servers: [Double] = [Double]()
    var serverNames: [String] = [String]()
    
    @IBOutlet weak var latBox: UILabel!
    @IBOutlet weak var lonBox: UILabel!
    @IBOutlet weak var locBox: UILabel!
    @IBOutlet weak var closestServer: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .AuthorizedAlways:
                /* Yes, always */
                createLocationManager(startImmediately: true)
            case .AuthorizedWhenInUse:
                /* Yes, only when our app is in use */
                createLocationManager(startImmediately: true)
            default:
                /* No */
                locBox.hidden = true
                closestServer.hidden = true
                latBox.text = "Location services have not "
                lonBox.text = "been enabled for this app"
                
            }
        }
        
        self.servers = [
            40.7033127,  //New York City lat
            -73.979681,  //New York City lon
            41.8337329,
            -87.7321555, //Chicago
            34.0204989,
            -118.4117325, //LA
            -22.9112335,
            -43.448334,  //Rio de Janeiro
            -33.7969235,
            150.9224326, // Sydney, Australia
            1.3147308,
            103.8470128  //Singapore
        ]

        self.serverNames = [
            "New York City, NY, USA",
            "Chicago, IL, USA",
            "Los Angeles, CA, USA",
            "Rio de Janeiro, Brazil",
            "Sydney, South New Wales, Australia",
            "Singapore"
        ]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations
        locations: [CLLocation]) {
            if locations.count == 0{
                //handle error here
                print("there was no location to use")
            } else {
                let newLocation = locations[0]
                
                lat = (newLocation.coordinate.latitude)
                lon = (newLocation.coordinate.longitude)
                latBox.text = "Latitude = \(lat)"
                lonBox.text = "Longitude = \(lon)"

                
                //Let's do some distance formula math :D
                var i: Int, shortestIter: Int
                var oldDist: Double, newDist: Double
                oldDist = 200
                shortestIter = 0
                for (i = 0; i < 12; i += 2) {
                    let dLon = servers[i+1] - lon
                    let dLat = servers[i] - lat
                    newDist = sqrt(abs(dLat) + abs(dLon))
                    if newDist <= oldDist {
                        oldDist = newDist
                        shortestIter = (i/2)  //returns 0 - 5 instead of 0 - 10
                    }
                    
                }
                let painLocation:String = serverNames[shortestIter]
                closestServer.text = "Your Hearthstone trauma is occurring on the Blizzard servers located in \(painLocation)!"
                
                
                
            }
    }
    
    func createLocationManager(startImmediately startImmediately: Bool){
        
        if let manager = locationManager{
            manager.delegate = self
            if startImmediately{
                manager.startUpdatingLocation()
            }
        }
    }
}