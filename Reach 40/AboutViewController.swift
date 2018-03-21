//
//  AboutViewController.swift
//  Reach 40
//
//  Created by Athanasios on 20/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true) {
            print("'About' view dismissed.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
