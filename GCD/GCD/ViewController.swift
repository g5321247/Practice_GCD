//
//  ViewController.swift
//  GCD
//
//  Created by George Liu on 2018/9/1.
//  Copyright © 2018 George Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var websiteName = ["name", "address", "head"]
    var onlineData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(name: "name")
        getData(name: "address")
        getData(name: "head")
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func getData(name: String) {
        
        guard let url = URL(string: "https://stations-98a59.firebaseio.com/\(name).json") else { return print("url error") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
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
            
        }
        dataTask.resume()
    }


}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return
//    }
//
//}


