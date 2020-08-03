//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimer: [String: Double] = ["Soft": 5.0, "Medium": 7.0, "Hard": 12.0]
    var boilTimer: Double? = nil
    var timer = Timer()
    var progress = 0.0
    var totalTime: Double? = nil
    let delta = 1.0
    
    @objc func updateCounter() {
        if boilTimer! >= 0.0 {
            timerLabel.text = String(Int(boilTimer!))
            print(progress)
            progressBar.progress = Float(progress / totalTime!)
            boilTimer! -= delta
            progress += delta
        }
    }
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0
        progress = 0
        let hardness = sender.currentTitle!
        boilTimer = eggTimer[hardness]!
        totalTime = eggTimer[hardness]!
        timer = Timer.scheduledTimer(timeInterval: delta, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
}
