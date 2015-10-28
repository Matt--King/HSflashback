//
//  ViewController.swift
//  HSFlashBack
//
//  Created by Matthew King on 10/27/15.
//  Copyright © 2015 Matthew King. All rights reserved.
//

import UIKit

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

class Settings_Page: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
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
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
            let svc = segue.destinationViewController as! Salt_Page
            svc.heroSelected = (picker.selectedRowInComponent(<#T##component: Int##Int#>))
        
    }

    
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
}




class Salt_Page: UIViewController {
    
    var heroSelected:Int!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var saltLabel: UIView!
    var imageName: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
