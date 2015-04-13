//
//  ViewController.swift
//  VideoAndGesture
//
//  Created by Daisuke Hirata on 4/13/15.
//  Copyright (c) 2015 Daisuke Hirata. All rights reserved.
//

import UIKit
import MediaPlayer
import AudioToolbox

class ViewController: UIViewController {
    
    var moviePlayer:MPMoviePlayerController!

    override func viewDidLoad() {
        super.viewDidLoad()        
        // Do any additional setup after loading the view, typically from a nib.
        var url:NSURL = NSURL(string: "http://www.gomplayer.jp/img/sample/mov_h264_aac.mov")!
        
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        self.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(moviePlayer.view)
        
        self.moviePlayer.fullscreen = true
        self.moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        self.moviePlayer.repeatMode = MPMovieRepeatMode.One
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerPlaybackDidFinishNotificationReceived:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerLoadStateDidChangeNotificationReceived:", name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerWillEnterFullscreenNotificationReceived:", name: MPMoviePlayerWillEnterFullscreenNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerWillExitFullscreenNotificationReceived:", name: MPMoviePlayerWillExitFullscreenNotification, object: nil)
    }

    func onMPMoviePlayerPlaybackDidFinishNotificationReceived(notification: NSNotification){
        let userInfo: NSDictionary = notification.userInfo!
        let reason = userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        println("onMPMoviePlayerPlaybackDidFinishNotificationReceived = " + String(reason))
    }
    
    func onMPMoviePlayerLoadStateDidChangeNotificationReceived(notification: NSNotification){
        let state = self.moviePlayer.loadState
        println("onMPMoviePlayerLoadStateDidChangeNotificationReceived = " + String(state.rawValue))
    }
    
    func onMPMoviePlayerWillEnterFullscreenNotificationReceived(notification: NSNotification){
        println("onMPMoviePlayerWillEnterFullscreenNotificationReceived")
    }
    
    func onMPMoviePlayerWillExitFullscreenNotificationReceived(notification: NSNotification){
        println("onMPMoviePlayerWillExitFullscreenNotificationReceived")
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.type == UIEventType.Motion && event.subtype == UIEventSubtype.MotionShake {
            NSLog("Shake Start")
            let soundIdRing:SystemSoundID = 1000  // new-mail.caf
            AudioServicesPlaySystemSound(soundIdRing)
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.type == UIEventType.Motion && event.subtype == UIEventSubtype.MotionShake {
            NSLog("Shake Stop")
        }
    }
    
}

