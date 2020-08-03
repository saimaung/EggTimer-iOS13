//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    let eggTimer: [String: Double] = ["Soft": 5.0, "Medium": 7.0, "Hard": 12.0]
    var boilTimer: Double? = nil
    var timer = Timer()
    var progress = 0.0
    var totalTime: Double? = nil
    let delta = 5.0
    var audioPlayer: AVAudioPlayer?
    
    @objc func updateCounter() {
        if boilTimer! >= 0.0 {
            timerLabel.text = String(Int(boilTimer!))
            progressBar.progress = Float(progress / totalTime!)
            boilTimer! -= delta
            progress += delta
            print(boilTimer!)
            if (boilTimer! == 0.0) {
                timer.invalidate()
                playSound()
            }
        }
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            audioPlayer = try AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let audioPlayer = audioPlayer else { return }

            audioPlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0
        progress = 0
        let hardness = sender.currentTitle!
        boilTimer = eggTimer[hardness]! * 6.0
        totalTime = eggTimer[hardness]!
        timer = Timer.scheduledTimer(timeInterval: delta, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
}
