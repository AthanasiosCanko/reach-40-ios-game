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
    
    var change_image_timer = Timer()
    var reset_image_timer = Timer()
    var star_timer = Timer()
    
    @IBOutlet weak var attempts_label: UILabel!
    @IBOutlet weak var dice_image: UIImageView!
    @IBOutlet weak var score_label: UILabel!
    @IBOutlet weak var arithmetic_label: UILabel!
    @IBOutlet weak var submit_high_score_label: UIButton!
    
    @objc func change_image() {
        dice_image.image = UIImage(named: "\(nr)_dice.png")
    }
    
    @objc func reset_image() {
        dice_image.image = UIImage(named: "tap_to_throw.png")
    }
    
    @objc func star_image() {
        dice_image.image = UIImage(named: "star_dice.png")
        UIView.animate(withDuration: 0.3) {
            self.dice_image.frame = CGRect(x: self.view.center.x - 100, y: self.view.center.y - 100, width: 200, height: 200)
        }
    }
    
    @IBAction func tap(_ sender: Any) {
        if won == false {
            nr = Int(arc4random_uniform(6)) + 1
            
            nr_of_attempts += 1
            attempts_label.text = "Nr. of attempts: \(nr_of_attempts)"
            
            UIView.animate(withDuration: 0.1, animations: {
                self.dice_image.alpha = 0
            })
            
            change_image_timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(PlayGameViewController.change_image), userInfo: nil, repeats: false)
            
            if nr % 2 == 0 {
                if score - nr >= 0 {score -= nr}
                else {score = 0}
                
                arithmetic_char = "-"
            }
            else {
                score += nr
                arithmetic_char = "+"
            }
            
            score_label.text = "Score: \(score)"
            
            UIView.animate(withDuration: 0.1) {
                self.dice_image.alpha = 1
            }
            
            if score >= 40 {
                arithmetic_label.textColor = UIColor(red: 0.6, green: 0.5, blue: 0, alpha: 1)
                arithmetic_label.text = "Congrats, you won!"
                won = true
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.dice_image.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 0, height: 0)
                })
                
                star_timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(PlayGameViewController.star_image), userInfo: nil, repeats: false)
                
                if (nr_of_attempts < high_score || high_score == 0) {
                    UserDefaults.standard.set(nr_of_attempts, forKey: "high_score")
                    submit_button_shown = true
                    UIView.animate(withDuration: 0.5, animations: {
                        self.view.layoutIfNeeded()
                        self.submit_high_score_label.alpha = 1
                    })
                }
            }
            else {
                
                if arithmetic_char == "+" {arithmetic_label.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)}
                else {arithmetic_label.textColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)}
                
                arithmetic_label.text = "\(arithmetic_char)\(nr)"
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            print("'Play Game' view dismissed.")
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
        
        UIView.animate(withDuration: 0.6) {
            self.dice_image.transform = self.dice_image.transform.rotated(by: .pi)
            self.dice_image.transform = self.dice_image.transform.rotated(by: .pi)
        }
        
        reset_image_timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(PlayGameViewController.reset_image), userInfo: nil, repeats: false)
        
        if self.submit_button_shown {
            self.submit_button_shown = false
            
            UIView.animate(withDuration: 0.5, animations: {
                self.submit_high_score_label.alpha = 0
            })
        }
    }
    
    @IBAction func submit_high_score(_ sender: Any) {
        let submit_score = self.storyboard?.instantiateViewController(withIdentifier: "high_score") as! SubmitScoreViewController
        self.present(submit_score, animated: true) {
            print("'Submit Score' view shown.")
        }
    }
    
    override func viewDidLayoutSubviews() {
        submit_high_score_label.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.dice_image.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dice_image.alpha = 0
        dice_image.center = view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
