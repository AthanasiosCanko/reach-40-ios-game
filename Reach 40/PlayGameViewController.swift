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
    var submit_button_shown = false
    
    var arithmetic_char = ""
    var dice_timer = Timer()
    
    @IBOutlet weak var attempts_label: UILabel!
    @IBOutlet weak var dice_image: UIImageView!
    @IBOutlet weak var score_label: UILabel!
    @IBOutlet weak var arithmetic_label: UILabel!
    @IBOutlet weak var submit_high_score_label: UIButton!
    
    @IBAction func tap(_ sender: Any) {
        if won == false {
            nr_of_attempts += 1
            nr = Int(arc4random_uniform(6)) + 1
            
            dice_image.image = UIImage(named: "\(nr)_dice.png")
            attempts_label.text = "Nr. of attempts: \(nr_of_attempts)"
            
            if nr % 2 != 0 {
                if score - nr >= 0 {
                    score -= nr
                }
                else {
                    score = 0
                }
                
                arithmetic_char = "-"
            }
            else {
                score += self.nr
                arithmetic_char = "+"
            }
            
            dice_appear()
            
            if score >= 40 {
                won = true
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
        
        if self.submit_button_shown {
            self.submit_button_shown = false
            
            UIView.animate(withDuration: 0.5, animations: {
                self.submit_high_score_label.center = CGPoint(x: self.submit_high_score_label.center.x, y: self.submit_high_score_label.center.y + 700)
            })
        }
    }
    
    func dice_appear() {
        score_label.text = "Score: \(score)"
        
        if score >= 40 {
            arithmetic_label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0, alpha: 1)
            arithmetic_label.text = "Congrats, you won!"
            won = true
            
            if (nr_of_attempts < high_score || high_score == 0) {
                UserDefaults.standard.set(nr_of_attempts, forKey: "high_score")
                submit_button_shown = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                    self.submit_high_score_label.center = CGPoint(x: self.submit_high_score_label.center.x, y: self.submit_high_score_label.center.y - 700)
                })
            }
        }
        else {
            if arithmetic_char == "+" {
                arithmetic_label.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
            }
            else {
                arithmetic_label.textColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
            }
            
            arithmetic_label.text = "\(arithmetic_char)\(nr)"
        }
    }
    
    @IBAction func submit_high_score(_ sender: Any) {
        let submit_score = self.storyboard?.instantiateViewController(withIdentifier: "high_score") as! SubmitScoreViewController
        self.present(submit_score, animated: true) {
            print("Submit score page presented.")
        }
    }
    
    override func viewDidLayoutSubviews() {
        submit_high_score_label.center = CGPoint(x: submit_high_score_label.center.x, y: submit_high_score_label.center.y + 700)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
