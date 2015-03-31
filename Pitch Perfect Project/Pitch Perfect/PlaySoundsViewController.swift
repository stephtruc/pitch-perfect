//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Stephanie Truchan on 3/20/15.
//  Copyright (c) 2015 Stephanie Truchan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    //declare global variable
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize variable
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        //convert NSUrl to AVAudio File & Initialize
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowly(sender: UIButton) {
        audioPlayer.stop()
       
         // prevent overlapping audio effects
        audioEngine.stop()
        audioEngine.reset()
        
        //Play audio slowly here
        audioPlayer.rate = 0.5
        //start audio from beginning...comment out if want it to continue from where it is
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.stop()
        
        // prevent overlapping audio effects
        audioEngine.stop()
        audioEngine.reset()
        
        //Play audio fast here
        audioPlayer.rate = 2.0
        //start audio from beginning...comment out if want it to continue from where it is
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
       audioPlayer.stop()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
      playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
      playAudioWithVariablePitch(-1000)
    }
    

}
