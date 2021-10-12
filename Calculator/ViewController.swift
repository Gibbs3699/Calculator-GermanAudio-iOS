//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    
    
    private var isFinishedTypingNumber: Bool = true
    
    @IBOutlet weak var displayLabel: UILabel!
    
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        guard let number = Double(displayLabel.text!) else{
            fatalError("Cant convert display label text to a Double.")
        }
        
        if let calcMethod = sender.currentTitle{
            if calcMethod == "+/-" {
                displayLabel.text = String(number * -1)
            }else if calcMethod == "AC"{
                displayLabel.text = "0"
            }else if calcMethod == "%"{
                displayLabel.text = String(number/100)
            }
        }
    
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber{
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            }else{
                if numValue == "."{
                    guard let currentDisplayValue = Double(displayLabel.text!) else{
                        fatalError("Cant convert display label text to a Double.")
                    }
                    let isInt = floor(currentDisplayValue) == currentDisplayValue
                    if !isInt{
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
        
        playSound(data: sender.currentTitle)
        sender.alpha = 0.5
        
        //Code should execute after 0.2 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0
        }
        
        func playSound(data:String?) {
            guard let url = Bundle.main.url(forResource: data , withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        //What should happen when a number is entered into the keypad
    
    }

}

