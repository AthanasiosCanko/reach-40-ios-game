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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}