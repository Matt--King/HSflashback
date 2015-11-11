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
    
    
    var servers: [Double]
    
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
            40.7033127,
            -73.979681,
            41.8337329,
            -87.7321555,
            34.0204989,
            -118.4117325,
            -22.9112335,
            -43.448334,
            -33.7969235,
            150.9224326,
            1.3147308,
            103.8470128
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
                //Hard code this for now, eventually we need to fix this
                closestServer.text = "Your Hearthstone trauma is occurring on the Blizzard servers located in New York City, NY, USA!"
                
                
                lat = (newLocation.coordinate.latitude)
                lon = (newLocation.coordinate.longitude)
                latBox.text = "Latitude = \(lat)"
                lonBox.text = "Longitude = \(lon)"
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