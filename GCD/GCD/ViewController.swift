//
//  ViewController.swift
//  GCD
//
//  Created by George Liu on 2018/9/1.
//  Copyright © 2018 George Liu. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var textLbl: UILabel!

}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dispatchGroup = DispatchGroup()

    let websiteName = ["name", "address", "head"]
    
    var onlineData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()

        tableView.delegate = self
        tableView.dataSource = self
        
        dispatchGroup.notify(queue: .main) {
            
            self.tableView.reloadData()
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData() {
        
        for address in websiteName {
            
            guard let url = URL(string: "https://stations-98a59.firebaseio.com/\(address).json") else { return print("url error") }
            
            let urlRequest = URLRequest(url: url)
            
            dispatchGroup.enter()

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    guard error == nil else { return print("error is not nil") }
                    
                    guard let data = data  else { return print("data error") }
                    
                    guard let response = response as? HTTPURLResponse else { return print("data error") }
                    
                    switch response.statusCode {
                        
                    case 200 ... 299:
                        
                        let result = String(decoding: data, as: UTF8.self)
                        self.onlineData.append(result)
                        
                    default:
                        print("errorCode: \(response.statusCode)")
                    }
                    self.dispatchGroup.leave()
                }
            }
            
            dataTask.resume()
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlineData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomCell else {
            print("No such cell")
            return UITableViewCell()
        }
        
       
            
            cell.textLbl.text = self.onlineData[indexPath.row]
            cell.textLbl.isHidden = false
        
        return cell
    }
}


