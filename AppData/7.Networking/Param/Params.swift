//
//  Params.swift
//  QRYTe
//
//  Created by nguyen tam on 8/27/19.
//  Copyright © 2019 VuNM. All rights reserved.
//

import Foundation
import ObjectMapper


class LoginParam: Mappable {
    var email: String?
    var password: String?
    
    init(){}
    init(email: String){
        self.email  = email
    }
    
    init(email: String, password: String){
        self.email  = email
        self.password = password
    }
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }

    func mapping(map: ObjectMapper.Map) {
        email <- map["email"]
        password <- map["password"]
    }
    
}
