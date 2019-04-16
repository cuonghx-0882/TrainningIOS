//
//  Province.swift
//  TrainningIOS
//
//  Created by cuonghx on 4/12/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//

import Foundation

class Province{
    var urbanDistricts = [String]()
    var name: String
    
    init(name : String, urbanDistricts: [String]) {
        self.urbanDistricts = urbanDistricts
        self.name = name
    }
}
