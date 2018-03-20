//
//  ViewController.swift
//  Reach 40
//
//  Created by Athanasios on 20/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func play_game(_ sender: Any) {
        let play_game = self.storyboard?.instantiateViewController(withIdentifier: "play_game") as! PlayGameViewController
        
        self.present(play_game, animated: true) {
            print("Game started.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

