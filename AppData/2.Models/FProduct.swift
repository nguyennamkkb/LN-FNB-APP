//
//  PProduct.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class FProduct: Mappable {
    var id: Int?
    var user_id: Int?
    var category_id: Int?
    var name: String?
    var price: Int?
    var description: String?
    var image: String?
    var cost: Int?
    var isHot: Int?
    var count: Int?
    var total: Int?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    var cksRequest: String?
    var timeRequest: Int?
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        category_id <- map["category_id"]
        name <- map["name"]
        price <- map["price"]
        description <- map["description"]
        image <- map["image"]
        cost <- map["cost"]
        isHot <- map["isHot"]
        count <- map["count"]
        total <- map["total"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
        
    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
}
