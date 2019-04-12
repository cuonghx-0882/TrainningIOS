//
//  ViewController.swift
//  TrainningIOS
//
//  Created by cuonghx on 4/12/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let idCell = "Cell TableView"
    
    private let arraytext = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", "Lorem Ipsum is simply dummy text of the printing and typesetting industry", "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged", "with the release of Letraset sheets containing Lorem Ipsum passages"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "MyTableCell", bundle: nil), forCellReuseIdentifier: idCell)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraytext.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! MyTableViewCell
        cell.label.text = arraytext[indexPath.row]
        return cell
    }
}
