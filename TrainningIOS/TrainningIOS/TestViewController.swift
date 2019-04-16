//
//  TestViewController.swift
//  TrainningIOS
//
//  Created by cuonghx on 4/13/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var constrain: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.contentOffset = CGPoint(x: 0, y: 250)
        constrain.constant = 250
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
