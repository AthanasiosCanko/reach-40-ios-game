//
//  HighScoresViewController.swift
//  Reach 40
//
//  Created by Athanasios on 20/03/2018.
//  Copyright © 2018 Athanasios. All rights reserved.
//

import UIKit

var high_score_arr = ["name": [String](), "score": [String]()]
class HighScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return high_score_arr["name"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row) - \(high_score_arr["name"]![indexPath.row]): \(high_score_arr["score"]![indexPath.row]) attempts"
        return cell
    }
    
    @IBOutlet weak var json_fetch_outlet: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var high_score_outlet: UILabel!
    @IBAction func reset_high_score(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "high_score")
        high_score = 0
        high_score_outlet.text = "My high score: \(high_score)"
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true) {
            print("High Scores dismissed.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        high_score_arr = ["name": [String](), "score": [String]()]
        high_score_outlet.text = "My high score: \(high_score)"
        json_fetch_outlet.text = "Please waiting, we are fetching data..."
        
        if let url = URL(string: "http://reach-40.herokuapp.com/all") {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.sync {
                        self.json_fetch_outlet.text = "Please check your internet connection."
                    }
                }
                else {
                    if let res = data {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: res, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            DispatchQueue.main.sync {
                                if let high_scores = jsonResponse["high_scores"] {
                                    for high_score in (high_scores as? NSArray)! {
                                        if let hs = high_score as? NSDictionary {
                                            print(hs["name"]!)
                                            
                                            let name = hs["name"] as! String
                                            let score = String(describing: hs["score"]!)
                                            high_score_arr["name"]?.append(name)
                                            high_score_arr["score"]?.append(score)
                                            self.json_fetch_outlet.text = "Top 100 High Scores\n (Worldwide)"
                                        }
                                        else {
                                            self.json_fetch_outlet.text = "Name/Score error, please try later."
                                        }
                                    }
                                }
                                else {
                                    self.json_fetch_outlet.text = "JSON error, please try later."
                                }
                                
                                self.table.reloadData()
                            }
                        }
                        catch {
                            self.json_fetch_outlet.text = "Do/Catch Swift failed. Please try later."
                        }
                    }
                    else {
                        self.json_fetch_outlet.text = "JSON error, please try later."
                    }
                }
            })
            task.resume()
        }
        else {
            json_fetch_outlet.text = "Sorry, we have a server error. Please try later."
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
