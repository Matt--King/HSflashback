//
//  Salt_Page_Controller.swift
//  HSFlashBack
//
//  Created by Matthew King on 11/10/15.
//  Copyright © 2015 Matthew King. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Salt_Page: UIViewController {
    
    
    @IBOutlet weak var saltLabel: UILabel!
    @IBOutlet weak var heroPortrait: UIImageView!
    var heroString: String!
    var audioPlayer: AVAudioPlayer!
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Tap the Screen",
            message: "Tap to truly experience saltiness", preferredStyle: .Alert)
        
        let firstAction = UIAlertAction(title: "Sounds Good", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController!.addAction(firstAction)
        self.presentViewController(alertController!, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //Set up the Emote and Image
        self.heroPortrait.image = UIImage(named: heroString)
        let heroName: String = heroString.stringByReplacingOccurrencesOfString("_", withString: " ")
        
        
        //update the number of times Hero X has made you salty
        
        
        var plist:NSMutableDictionary? = [:]
        let fileManager = NSFileManager.defaultManager()
        let path = NSTemporaryDirectory() + "saltsim.plist"
        if(!fileManager.fileExistsAtPath(path)) {
            plist = [
                "Malfurion_Stormrage" : 0,
                "Rexxar" : 0,
                "Jaina_Proudmoore" : 0,
                "Uther_Lightbringer" : 0,
                "Anduin_Wrynn" : 0,
                "Valeera_Sanguinar" : 0,
                "Thrall" : 0,
                "Guldan" : 0,
                "Garrosh_Hellscream" : 0
            ]
            plist!.writeToFile(path, atomically:true)
        }
        plist = NSMutableDictionary(contentsOfFile: path)
        plist![heroString] = (plist![heroString]! as! Int)+1
        plist!.writeToFile(path, atomically:true)
        
        
        
        
        saltLabel.text = "\(heroName) has made you salty \(plist![heroString]!) times"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func emotePress(sender: AnyObject) {
        
        playSound(heroString)
        
    }
    
    //play a sound on tap
    func playSound(soundName: String)
    {
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: "mp3")!)
        do{
            self.audioPlayer = try AVAudioPlayer(contentsOfURL:sound)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch {
            print("Error getting the audio file")
        }
    }
    
    
}