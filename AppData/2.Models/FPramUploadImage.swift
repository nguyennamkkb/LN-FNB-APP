//
//  FPramUploadImage.swift
//  LN FNB
//
//  Created by namnl on 18/11/2023.
//

import Foundation
import ObjectMapper

class FPramUploadImage: Mappable {
    var cksRequest: String?
    var timeRequest: Int?
    var user_id: Int?
    var base64Image: String?
    var idSanPham: Int?
    var createAt: Int?

    init(){
        sign()
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
        user_id <- map["user_id"]
        base64Image <- map["base64Image"]
        idSanPham <- map["idSanPham"]
        createAt <- map["createAt"]
       
    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
        self.createAt = mili
    }
}
