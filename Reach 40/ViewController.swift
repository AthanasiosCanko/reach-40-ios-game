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
    
    @IBAction func high_scores(_ sender: Any) {
        let high_scores = self.storyboard?.instantiateViewController(withIdentifier: "high_scores") as! HighScoresViewController
        
        self.present(high_scores, animated: true) {
            print("High scores page shown.")
        }
    }
    
    override func viewDidLayoutSubviews() {
        if let temp = UserDefaults.standard.object(forKey: "high_score") as? Int {
            high_score = temp
        }
        
        print(high_score)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

