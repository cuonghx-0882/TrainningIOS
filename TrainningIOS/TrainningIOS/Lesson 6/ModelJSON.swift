//
//  ModelJSON.swift
//  TrainningIOS
//
//  Created by cuonghx on 4/17/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//

import Foundation
import ObjectMapper

class ModelJSON : Mappable{
    
    var id: Int?
    var nodeId: String?
    var name: String?
    var fullName: String?
    var owner: Owner?
    var html: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.nodeId <- map["node_id"]
        self.name <- map["name"]
        self.fullName <- map["full_name"]
        self.owner <- map["owner"]
        self.html <- map["html_url"]
    }
    
    
}
class Owner: Mappable {
    var login: String?
    var id: Int?
    var urlImage: String?
    var htmlURL: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.login <- map["login"]
        self.id <- map["id"]
        self.urlImage <- map["avatar_url"]
        self.htmlURL <- map["html_url"]
    }
    
}
