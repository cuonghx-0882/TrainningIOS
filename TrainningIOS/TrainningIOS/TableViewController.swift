//
//  TableViewController.swift
//  TrainningIOS
//
//  Created by cuonghx on 4/12/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var provinces = [Province]()
    private var checkReload = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(handleEditButton))
        self.navigationItem.rightBarButtonItem = editButton
        
        self.tableView.rowHeight = 50
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(obserKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(obserKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.setupData()
    }
    @objc private func obserKeyboard(_ notification : Notification){
        if notification.name == .UIKeyboardWillShow {
            checkReload = false
        }else {
            checkReload = true
        }
    }
    @objc private func refreshData(_ refresh : UIRefreshControl){
        refresh.endRefreshing()
        self.tableView.reloadData()
    }
    @objc private func handleEditButton(_ button : UIBarButtonItem){
        self.tableView.isEditing = !self.tableView.isEditing
        if self.tableView.isEditing {
            button.title = "Done"
        }else {
            button.title = "Edit"
        }
    }
    
    private func setupData(){
        var province = Province(name: "Hà Nội", urbanDistricts: ["Ba Đình", "Hoàn Kiếm", "Đống Đa", "Hai Bà Trưng", "Cầu Giấy", "Thanh Xuân", "Hoàng Mai", "Long Biên", "Tây Hồ", "Nam Từ Liêm", "Bắc Từ Liêm"])
        provinces.append(province)
        province = Province(name: "Hồ Chí Minh", urbanDistricts: ["Quận 1", "Quận 2", "Quận 3", "Quận 4", "Quận 5", "Quận 6", "Quận 7", "Quận 8", "Quận 9" ,"Quận 10" ,"Quận 11" ,"Quận 12", "Tân Bình", "Tân Phú", "Bình Tân", "Phú Nhuận", "Gò Vấp", "Bình Thạnh", "Thủ Đức"])
        provinces.append(province)
        province = Province(name: "Đà Nẵng", urbanDistricts: ["Hải Châu", "Thanh Khê", "Ngũ Hành Sơn", "Liên Chiểu", "Cẩm Lệ"])
        provinces.append(province)
        province = Province(name: "Cần Thơ", urbanDistricts: ["Ninh Kiều", "Bình Thuỷ", "Cái Răng", "Ô Môn", "Thốt Nốt"])
        provinces.append(province)
    }

}
extension TableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return provinces.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provinces[section].urbanDistricts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MyTableViewCell
        if indexPath.row < self.provinces[indexPath.section].urbanDistricts.count{
            cell.label.text = self.provinces[indexPath.section].urbanDistricts[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.provinces[section].name
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height)
//
//        UIView.animate(
//            withDuration: 0.4,
//            delay: 0.25 * Double(indexPath.row),
//            usingSpringWithDamping: 0.4,
//            initialSpringVelocity: 0.1,
//            options: [.curveEaseInOut],
//            animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0)
//        })
        let lastRowIndex = tableView.numberOfRows(inSection: self.provinces.count - 1)
        if indexPath.row == lastRowIndex - 1 {
            self.checkReload = true
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.provinces[indexPath.section].urbanDistricts.remove(at: indexPath.row)
        }else if editingStyle == .insert {
            let alert = UIAlertController(title: "Thêm quận nội thành", message: "Nhập tên quận nội thành cho \(self.provinces[indexPath.section].name)", preferredStyle: .alert)
            alert.addTextField { (tf) in
                tf.placeholder = "Tên"
            }
            func handle(_ act : UIAlertAction){
                let tf = alert.textFields![0]
                self.provinces[indexPath.section].urbanDistricts.append(tf.text!)
                self.tableView.reloadData()
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default , handler: handle))
            
            self.present(alert, animated: true, completion: nil)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if fromIndexPath.section == to.section{
            let from = self.provinces[fromIndexPath.section].urbanDistricts.remove(at: fromIndexPath.row)
            self.provinces[fromIndexPath.section].urbanDistricts.insert(from, at: to.row)
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.row ==  self.provinces[indexPath.section].urbanDistricts.count - 1 {
            return .insert
        }
        return .delete
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSet = scrollView.contentOffset.y
        let maxiumoffset = scrollView.contentSize.height - scrollView.frame.height
        
        if maxiumoffset - contentOffSet <= 100 && checkReload{
            checkReload = false
            self.provinces[self.provinces.count - 1].urbanDistricts.append("cuonghx")
            self.tableView.reloadData()
        }
    }
}
