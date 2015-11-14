//
//  Settings_Controller.swift
//  HSFlashBack
//
//  Created by Matthew King on 11/10/15.
//  Copyright © 2015 Matthew King. All rights reserved.
//

import Foundation
import UIKit


class Settings_Page: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    // Custom Hero Portrait Feature
    
    @IBAction func loadImage(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
        
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Oops",
                message: "We can't seem to find your device's camera.", preferredStyle: .Alert)
            
            let firstAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController!.addAction(firstAction)
            self.presentViewController(alertController!, animated: true, completion: nil)

        }
        
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

