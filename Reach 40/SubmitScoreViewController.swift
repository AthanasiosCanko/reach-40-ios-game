//
//  SubmitScoreViewController.swift
//  Reach 40
//
//  Created by Athanasios on 20/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

class SubmitScoreViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func submit(_ sender: Any) {
        let username = textField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: " ")
        
        if username.count > 1 {
            output.text = "Please use no spaces."
        }
        else {
            var message = ""
            let high_score = UserDefaults.standard.object(forKey: "high_score")
            
            output.text = "Attempting to submit, please wait..."
            
            if username[0] != "" {
                if let url = URL(string: "http://reach-40.herokuapp.com/high_score") {
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.httpBody = "name=\(username[0])&score=\(high_score!)".data(using: String.Encoding.utf8)
                    
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if error != nil {
                            DispatchQueue.main.sync {
                                self.output.text = "Can't submit. Please check your internet connection."
                            }
                        }
                        else {
                            if let res = data {
                                print(res)
                                do {
                                    let jsonResponse = try JSONSerialization.jsonObject(with: res, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                    
                                    if jsonResponse["message"] != nil {
                                        message = jsonResponse["message"]! as! String
                                    }
                                    else {
                                        message = "JSON error, please try again later."
                                    }
                                }
                                catch {
                                    message = "Do/Catch Swift failed. Please try later."
                                }
                                
                                DispatchQueue.main.sync {
                                    self.output.text = message
                                }
                            }
                        }
                    }
                    task.resume()
                }
                else {
                    output.text = "Sorry, we have a server error. Please try later."
                }
            }
            else {
                output.text = "Please type a username."
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true) {
            print("'Submit Score' view dismissed.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
