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
    
    
    @IBOutlet weak var emoteButton: UIButton!
    @IBOutlet weak var saltLabel: UILabel!
    @IBOutlet weak var heroPortrait: UIImageView!
    var heroString: String!
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //Set up the Emote and Image
        self.heroPortrait.image = UIImage(named: heroString)
        let heroName: String = heroString.stringByReplacingOccurrencesOfString("_", withString: " ")
        saltLabel.text = heroName + " makes you salty"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func emotePress(sender: UIButton) {
        
        playSound("audiofile")
        
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