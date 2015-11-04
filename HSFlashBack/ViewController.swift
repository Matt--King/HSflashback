//
//  ViewController.swift
//  HSFlashBack
//
//  Created by Matthew King on 10/27/15.
//  Copyright © 2015 Matthew King. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

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

class Salt_Page: UIViewController, AVAudioPlayerDelegate, UIGestureRecognizerDelegate {
    
    
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
    @IBAction func onHeroTap(sender: UITapGestureRecognizer) {
        print("tap")
        var player = AVAudioPlayer()
       /* let sound = NSURL(fileURLWithPath:
            NSBundle.mainBundle().pathForResource("Anduin_Wrynn_", ofType:
                "mp3")!)
        do{
            print("Loading sound")
            let audioPlayer = try
                AVAudioPlayer(contentsOfURL:sound)
            print("Preparing to play")
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            print("Play")
            audioPlayer.play()
        }catch {
            print("Error getting the audio file")
        }
        */
        
        let path = NSBundle.mainBundle().pathForResource("Anduin_Wrynn_", ofType:"mp3")
        let fileURL = NSURL(fileURLWithPath: path!)
        do {
        player = try
            AVAudioPlayer(contentsOfURL: fileURL)
        player.prepareToPlay()
        player.delegate = self
        player.play()
        } catch {
            print("bork")
        }
    }
}