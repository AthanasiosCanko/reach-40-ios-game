//
//  ViewController.swift
//  Reach 40
//
//  Created by Athanasios on 20/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

var high_score = 0
class ViewController: UIViewController {
    
    @IBOutlet weak var play_game_outlet: UIButton!
    @IBOutlet weak var rules_outlet: UIButton!
    @IBOutlet weak var high_scores_outlet: UIButton!
    @IBOutlet weak var about_outlet: UIButton!
    
    @IBOutlet weak var reach_40_image: UIImageView!
    @IBOutlet weak var reach_40_label: UILabel!
    
    @IBAction func play_game(_ sender: Any) {
        let play_game = self.storyboard?.instantiateViewController(withIdentifier: "play_game") as! PlayGameViewController
        
        self.present(play_game, animated: true) {
            print("Game started.")
        }
    }
    
    @IBAction func rules(_ sender: Any) {
        let rules = self.storyboard?.instantiateViewController(withIdentifier: "rules") as! RulesViewController
        
        self.present(rules, animated: true) {
            print("'Rules' view shown.")
        }
    }
    
    @IBAction func high_scores(_ sender: Any) {
        let high_scores = self.storyboard?.instantiateViewController(withIdentifier: "high_scores") as! HighScoresViewController
        
        self.present(high_scores, animated: true) {
            print("'High Scores' view shown.")
        }
    }
    
    @IBAction func about(_ sender: Any) {
        let about = self.storyboard?.instantiateViewController(withIdentifier: "about") as! AboutViewController
        self.present(about, animated: true) {
            print("'About' shown.")
        }
    }
    
    override func viewDidLayoutSubviews() {
        if let temp = UserDefaults.standard.object(forKey: "high_score") as? Int {
            high_score = temp
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate_elements()
    }
    
    func animate_elements() {
        play_game_outlet.alpha = 0
        rules_outlet.alpha = 0
        high_scores_outlet.alpha = 0
        about_outlet.alpha = 0
        
        reach_40_image.alpha = 0
        reach_40_label.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.play_game_outlet.alpha = 1
            self.reach_40_image.alpha = 1
        }
        
        UIView.animate(withDuration: 0.8) {
            self.rules_outlet.alpha = 1
            self.reach_40_label.alpha = 1
        }
        
        UIView.animate(withDuration: 1.1) {
            self.high_scores_outlet.alpha = 1
        }
        
        UIView.animate(withDuration: 1.4) {
            self.about_outlet.alpha = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
