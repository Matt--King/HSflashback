//
//  Sim_Picker_Page_Controller.swift
//  HSFlashBack
//
//  Created by Matthew King on 11/10/15.
//  Copyright © 2015 Matthew King. All rights reserved.
//

import Foundation
import UIKit


class Salt_Sim_Page: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var saltCountLabel: UILabel!
    let saltCountKey = "saltCount"
    var saltCountVal: NSInteger = 0
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = NSBundle.mainBundle().pathForResource("hsfbData", ofType: "plist")
        
        let data = NSDictionary(contentsOfFile: path!)
        if let dict = data{
            saltCountVal = dict.objectForKey(saltCountKey) as! NSInteger
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = ["Druid", "Hunter", "Mage", "Paladin", "Priest",  "Rogue", "Shaman", "Warlock", "Warrior"]
        self.saltCountLabel.text = "Number of times you've been salty: \(saltCountVal)."
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
            
            //Increment the salt count and write to the stored file
            //This functionality works on the emulator but not an iPod. y u do dis apple
            let path = NSBundle.mainBundle().pathForResource("hsfbData", ofType: "plist")
            let dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
            let saltCountValInc = saltCountVal + 1
            dict.setValue(saltCountValInc, forKey: saltCountKey)
            dict.writeToFile(path!, atomically: false)
            
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

