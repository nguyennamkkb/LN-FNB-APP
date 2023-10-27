//
//  PStore.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PStore: Mappable {
    
    var id: Int?
    var email: String?
    var password: String?
    var name_own: String?
    var storeName: String?
    var desciption: String?
    var address: String?
    var logo: String?
    var phone: String?
    var qr: String?
    var createAt: String?
    var updateAt: String?
    var otp: String?
    var status: Int?
    var access_token: String?
    var cksRequest: String?
    var timeRequest: Int?
    
    
    
    init (){}
    
    init (phone: String){
        self.phone = phone
    }
    
    init (email: String, password: String){
        self.email = email
        self.password = password
        sign()
    }
    
    init (storeName: String,phone: String,address: String,email: String,password: String){
        self.storeName = storeName
        self.phone = phone
        self.address = address
        self.email = email
        self.password = password
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        email <- map["email"]
        password <- map["password"]
        name_own <- map["name_own"]
        storeName <- map["storeName"]
        desciption <- map["desciption"]
        phone <- map["phone"]
        address <- map["address"]
        logo <- map["logo"]
        qr <- map["qr"]
        otp <- map["otp"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
        access_token <- map["access_token"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
}
