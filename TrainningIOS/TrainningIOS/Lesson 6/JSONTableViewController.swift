//
//  JSONTableViewController.swift
//  TrainningIOS
//
//  Created by cuonghx on 4/17/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//

import UIKit
import Alamofire

class JSONTableViewController: UITableViewController, URLSessionDelegate {
    
    lazy var tableData = [ModelJSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 150
//        self.loadData()
        loadDataUsingAlamofire()
    }
    
    private func loadDataUsingAlamofire(){
        Alamofire.request("https://api.github.com/users/google/repos").authenticate(user: "cuonghx2709", password: "Cuonghx5238").response { (res) in
            if let data = res.data {
                self.parserJSONUSingMapping(data)
                self.tableView.reloadData()
            }
        }
    }
    
    private func loadData(){
        let config = URLSessionConfiguration.default
        let userPasswordString = "cuonghx2709:Cuonghx5238"
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: URL(string: "https://api.github.com/users/google/repos")!) { (data, res, err) in
            if err != nil {return}
            self.parserJSONUSingMapping(data!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    private func parserJSON(_ data : Data){
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        //            print(json)
        if let array = json as? [Any] {
            for index in array {
                let dictiondary = index as! [String : Any]
                print(dictiondary["id"])
            }
        }
    }
    private func parserJSONUSingMapping(_ data : Data){
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        //            print(json)
        if let array = json as? [Any] {
            for index in array {
                if let dic = index as? [String : Any]{
                    let model = ModelJSON(JSON: dic)
                    self.tableData.append(model!)
//                    print(model?.owner?.urlImage)
                }
            }
        }
    }
    
    // MARK : - TableView Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JSONTableCell", for: indexPath) as! JSONTableViewCell
        cell.setupData(self.tableData[indexPath.row])
        return cell
    }
}
