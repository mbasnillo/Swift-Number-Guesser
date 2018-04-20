//
//  GameViewController.swift
//  Number Guesser
//
//  Created by Miles R. Basnillo on 20/04/2018.
//  Copyright © 2018 Miles R. Basnillo. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    var numToGuess: Int!
    var score: Int = 0
    var life: Int = 3
    
    let synthesizer = AVSpeechSynthesizer()
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        self.numToGuess = self.randomNumber(upperBound: 100)
        
        let wrongNumber = self.randomNumber(upperBound: 100)
        
        let flipCoin = self.randomNumber(upperBound: 2)
        
        if (flipCoin == 0) {
            self.leftButton.setTitle("\(self.numToGuess!)", for: .normal)
            self.leftButton.tag = self.numToGuess!
            self.rightButton.setTitle("\(wrongNumber)", for: .normal)
            self.rightButton.tag = wrongNumber
        } else {
            self.rightButton.setTitle("\(self.numToGuess!)", for: .normal)
            self.rightButton.tag = self.numToGuess!
            self.leftButton.setTitle("\(wrongNumber)", for: .normal)
            self.leftButton.tag = wrongNumber
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        let numberAsText = numberFormatter.string(for: numToGuess)
        let utterance = AVSpeechUtterance(string: numberAsText!)
        synthesizer.speak(utterance)
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        if (sender.tag == self.numToGuess) {
            // win
            self.score = self.score + 1
            self.scoreLabel.text = "Score: \(self.score)"
            self.startButtonPressed(self.startButton)
        } else {
            // lose
            self.life = self.life - 1
            if (self.life == 0) {
                let utterance = AVSpeechUtterance(string: "Game Over")
                synthesizer.speak(utterance)
                self.performSegue(withIdentifier: "gameOver", sender: nil)
            } else {
                self.lifeLabel.text = "Life: \(self.life)"
                self.startButtonPressed(self.startButton)
            }
            
        }
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        if (sender.tag == self.numToGuess) {
            // win
            self.score = self.score + 1
            self.scoreLabel.text = "Score: \(self.score)"
            self.startButtonPressed(self.startButton)
        } else {
            // lose
            self.life = self.life - 1
            if (self.life == 0) {
                let utterance = AVSpeechUtterance(string: "Game Over")
                synthesizer.speak(utterance)
                self.performSegue(withIdentifier: "gameOver", sender: nil)
            } else {
                self.lifeLabel.text = "Life: \(self.life)"
                self.startButtonPressed(self.startButton)
            }
            
        }
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        let utterance = AVSpeechUtterance(string: "Restarting")
        synthesizer.speak(utterance)
        self.life = 3
        self.score = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomNumber(upperBound: UInt32) -> Int {
        return Int(arc4random_uniform(upperBound))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
