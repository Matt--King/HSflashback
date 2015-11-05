//
//  ViewController.swift
//  HSFlashBack
//
//  Created by Matthew King on 10/27/15.
//  Copyright © 2015 Matthew King. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreLocation

//MARK: Home Page

class Home_Page: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


class Simulators_Page: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // navigationItem.title = "One"
        navigationItem.title = "Test"
    }
    
    
  

}

class Settings_Page: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    // Custom Hero Portrait Feature
    
    @IBAction func loadImage(sender: UIButton) {
        
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
            }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
          //  imageView.contentMode = .ScaleAspectFill
            self.imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    // Share App Feature
    
    @IBAction func showShare(sender: UIButton) {
        let firstActivityItem = "I'm loving the Hearthstone Flashbacks App!"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Full class
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


class Salt_Sim_Page: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = ["Druid", "Hunter", "Mage", "Paladin", "Priest",  "Rogue", "Shaman", "Warlock", "Warrior"]
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: UIPickerView functions
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (sender!.isEqual(self.launchButton)) {
        var saltVC = Salt_Page()
        saltVC = segue.destinationViewController as! Salt_Page
        
        var temp: String
        let input = picker.selectedRowInComponent(0)
        switch(input) {
        case 0: //Druid
            temp = "Malfurion_Stormrage"
        case 1: //Hunter
            temp = "Rexxar"
        case 2: //Mage
            temp = "Jaina_Proudmoore"
        case 3: //Paladin
            temp = "Uther_Lightbringer"
        case 4: //Priest
            temp = "Anduin_Wrynn"
            print(temp)
        case 5: //Rogue
            temp = "Valeera_Sanguinar"
        case 6: //Shaman
            temp = "Thrall"
        case 7: //Warlock
            temp = "Guldan"
        default: //Warrior
            temp = "Garrosh_Hellscream"
        }
        
        saltVC.heroString = temp
        }
    }

}

class Salt_Page: UIViewController {
    
    
    @IBOutlet weak var saltLabel: UILabel!
    @IBOutlet weak var heroPortrait: UIImageView!
    var heroString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //Set up the Emote and Image
        self.heroPortrait.image = UIImage(named: heroString)
        let heroName: String = heroString.stringByReplacingOccurrencesOfString("_", withString: " ")
        saltLabel.text = heroName + " makes you salty"
        print(heroString)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}

class GPS_Page: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var lat: Double!
    var lon: Double!
    
    @IBOutlet weak var latBox: UILabel!
    @IBOutlet weak var lonBox: UILabel!
    
    @IBOutlet weak var locationBox: UILabel!
    
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
                latBox.text = "Location services have not "
                lonBox.text = "been enabled for this app"
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func locationManager(manager: CLLocationManager, didUpdateLocations
            locations: [CLLocation]) {
                if locations.count == 0{
                    //handle error here
                    return
                }
                let newLocation = locations[0]
                
                locationBox.hidden = false
                lat = (newLocation.coordinate.latitude )
                lon = (newLocation.coordinate.longitude)
                latBox.text = "Latitude = \(lat)"
                lonBox.text = "Longitude = \(lon)"
                
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