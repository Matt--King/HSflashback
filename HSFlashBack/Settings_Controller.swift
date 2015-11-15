//
//  Settings_Controller.swift
//  HSFlashBack
//
//  Created by Matthew King on 11/10/15.
//  Copyright © 2015 Matthew King. All rights reserved.
//

import Foundation
import UIKit


class Settings_Page: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var heroPortrait: UIView!
    @IBOutlet weak var nameField: UITextField!
    var pictureTaken = false
    
    
    // Share App Feature
    @IBAction func showShare(sender: UIButton) {
        let firstActivityItem = "I'm loving the Hearthstone Flashbacks App!"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    // Custom Hero Portrait Feature
   
    @IBAction func loadImage(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
        
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Oops",
                message: "We can't find your device's camera.", preferredStyle: .Alert)
            
            let firstAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController!.addAction(firstAction)
            self.presentViewController(alertController!, animated: true, completion: nil)

        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //  imageView.contentMode = .ScaleAspectFill
            self.imageView.image = pickedImage
            pictureTaken = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Limit text field length
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (range.length + range.location > textField.text!.characters.count ){
            return false;
        }
        
        let length = textField.text!.characters.count + string.characters.count - range.length
        
        return length <= 15
        
    }
    
    // Closes text field keyboard on return press
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Saving the Custom Hero Portrait
    @IBAction func saveHeroPortrait(sender: AnyObject) {
        // access big view
        // turn view into uiima
        UIGraphicsBeginImageContext(heroPortrait.bounds.size);
        heroPortrait.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(screenShot, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your hero portrait has been saved to your photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }

    // Back button check for edits
    @IBAction func backCheck(sender: UIButton){
        // pictureTaken is a non optional bool. isEmpty is an optional Bool. ?? means if Bool is not nil, value, else, false
        if ((pictureTaken) || (nameField.text?.isEmpty != true))  {
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Careful",message: "Picture and text edits will not be saved!", preferredStyle: .Alert)
            
            let firstAction = UIAlertAction(title: "Keep Editing", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController!.addAction(firstAction)
            
            //let secondAction = UIAlertAction(title: "Leave", style: UIAlertActionStyle.Default,
            //    handler: alertSegueHandler )
            //alertController!.addAction(secondAction)
            self.presentViewController(alertController!, animated: true, completion: nil)
        
        }
    }
    
    func alertSegueHandler(alert: UIAlertAction!) {
        performSegueWithIdentifier("SetToHomeSeg", sender: nil)
    }
    
    
    // Defaults / Misc
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self;
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

