//
//  RulesViewController.swift
//  Reach 40
//
//  Created by Athanasios on 21/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {
    
    @IBOutlet weak var one_dice: UIImageView!
    @IBOutlet weak var three_dice: UIImageView!
    @IBOutlet weak var five_dice: UIImageView!
    
    @IBOutlet weak var two_dice: UIImageView!
    @IBOutlet weak var four_dice: UIImageView!
    @IBOutlet weak var six_dice: UIImageView!
    
    @IBOutlet weak var rules_label: UILabel!
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true) {
            print("'Rules' view dismissed.")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        one_dice.alpha = 0
        three_dice.alpha = 0
        five_dice.alpha = 0
        
        two_dice.alpha = 0
        four_dice.alpha = 0
        six_dice.alpha = 0
        
        rules_label.alpha = 0
    }
    
    override func viewDidLayoutSubviews() {
        UIView.animate(withDuration: 1.0) {
            self.one_dice.alpha = 1
            self.three_dice.alpha = 1
            self.five_dice.alpha = 1
            self.two_dice.alpha = 1
            self.four_dice.alpha = 1
            self.six_dice.alpha = 1
            self.rules_label.alpha = 1
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
