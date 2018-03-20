//
//  PlayGameViewController.swift
//  Reach 40
//
//  Created by Athanasios on 20/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    var won = false
    var score = 0
    var nr_of_attempts = 0
    var nr = Int()
    
    var arithmetic_char = ""
    var dice_timer = Timer()
    
    @IBOutlet weak var attempts_label: UILabel!
    @IBOutlet weak var dice_image: UIImageView!
    @IBOutlet weak var score_label: UILabel!
    @IBOutlet weak var arithmetic_label: UILabel!
    
    @IBAction func tap(_ sender: Any) {
        if won == false {
            UIView.animate(withDuration: 0.2) {
                
                self.dice_image.alpha = 0
                self.nr_of_attempts += 1
                
                self.nr = Int(arc4random_uniform(6)) + 1
                
                if self.nr % 2 == 0 {
                    if self.score - self.nr >= 0 {
                        self.score -= self.nr
                    }
                    else {
                        self.score = 0
                    }
                    
                    self.arithmetic_char = "-"
                }
                else {
                    self.score += self.nr
                    self.arithmetic_char = "+"
                }
                
                if self.score >= 40 {
                    self.won = true
                }
                
                print(self.score)
                
                self.dice_timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PlayGameViewController.dice_appear), userInfo: nil, repeats: false)
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            print("Back to menu.")
        })
    }
    
    @IBAction func reset(_ sender: Any) {
        won = false
        score = 0
        nr_of_attempts = 0
        nr = Int()
        
        arithmetic_char = ""
        score_label.text = "Score: 0"
        attempts_label.text = "Nr. of attempts: 0"
        arithmetic_label.text = ""
        
        UIView.animate(withDuration: 0.5) {
            // <<<<< TO FIX >>>>>
 
            self.dice_image.image = UIImage(named: "tap_to_throw.png")
            self.dice_image.transform = self.dice_image.transform.rotated(by: .pi)
            self.dice_image.transform = self.dice_image.transform.rotated(by: .pi)
        }
    }
    
    @objc func dice_appear() {
        UIView.animate(withDuration: 0.2) {
            self.score_label.text = "Score: \(self.score)"
            if self.score >= 40 {
                self.arithmetic_label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0, alpha: 1)
                self.arithmetic_label.text = "Congrats, you won!"
                self.won = true
            }
            else {
                if self.arithmetic_char == "+" {
                    self.arithmetic_label.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
                }
                else {
                    self.arithmetic_label.textColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
                }
                
                self.arithmetic_label.text = "\(self.arithmetic_char)\(self.nr)"
            }
            
            self.dice_image.image = UIImage(named: "\(self.nr)_dice.png")
            self.dice_image.alpha = 1
            
            self.attempts_label.text = "Nr. of attempts: \(self.nr_of_attempts)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
