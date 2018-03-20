//
//  HighScoresViewController.swift
//  Reach 40
//
//  Created by Athanasios on 20/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

class HighScoresViewController: UIViewController {

    @IBOutlet weak var high_score_outlet: UILabel!
    @IBAction func reset_high_score(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "high_score")
        high_score = 0
        high_score_outlet.text = "My high score: \(high_score)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        high_score_outlet.text = "My high score: \(high_score)"
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true) {
            print("High Scores dismissed.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
