//
//  JSONTableViewCell.swift
//  TrainningIOS
//
//  Created by cuonghx on 4/17/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//

import UIKit
import Kingfisher

class JSONTableViewCell: UITableViewCell {

    @IBOutlet weak var uiImage: UIImageView!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelURL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    internal func setupData(_ model : ModelJSON) {
        let url = URL(string: (model.owner?.urlImage)!)
        
//        let data = try! Data(contentsOf: url!)
//        self.uiImage.image = UIImage(data: data)
        self.uiImage.kf.setImage(with: url)
        
        self.labelID.text = "Id: \(model.id!)"
        self.labelName.text = "Name: " + model.name!
        self.labelURL.text = "URL: " + (model.owner?.htmlURL)!
    }
}
