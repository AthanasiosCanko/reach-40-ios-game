//
//  AboutViewController.swift
//  Reach 40
//
//  Created by Athanasios on 20/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var about_label: UILabel!
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true) {
            print("'About' view dismissed.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        about_label.alpha = 0
    }
    
    override func viewDidLayoutSubviews() {
        UIView.animate(withDuration: 1) {
            self.about_label.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
