//
//  HomeViewController.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/6/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class HomeViewController: UIViewController {
    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var musicButton: UIButton!
    
    @IBAction func controlMusic(sender: AnyObject){
        if (isPlaying==true){
            print("isPlaying")
            audioPlayer.pause()
            musicButton.setImage(UIImage(named: "speakerStop2"), forState: .Normal)
            isPlaying = false
        }else{
            print("isNotPlaying")
            audioPlayer.play()
        musicButton.setImage(UIImage(named: "speakerPlay2"), forState: .Normal)
            isPlaying = true

        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") 
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        if let name = PFUser.currentUser()?["name"] as? String {
            self.nameLabel.text = "Hey " + name
        }
        playBackgroundMusic("Dexter Britain - Same Old Moments - 01 Breaking Light")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playBackgroundMusic(filename: String) {
        
        //The location of the file and its type
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "mp3")
        
        //Returns an error if it can't find the file name
        if (url == nil) {
            print("Could not find the file \(filename)")
        }
        
        //Assigns the actual music to the music player
        do{
            try audioPlayer = AVAudioPlayer(contentsOfURL: url!, fileTypeHint:nil)
        } catch{
            
        }
        
        
        //A negative means it loops forever
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        isPlaying = true
    }
}
