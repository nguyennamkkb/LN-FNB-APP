//
//  CommonService.swift
//  QRYTe
//
//  Created by nguyen tam on 8/26/19.
//  Copyright © 2019 VuNM. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

fileprivate class ListCommonService {
    
    // account
    static let user = ServiceManager.ROOT + "user"
    static let checkuser = ServiceManager.ROOT + "user/checkuser"
    static let table = ServiceManager.ROOT + "tables"
    static let auth = ServiceManager.ROOT + "auth/signin"
    static let category = ServiceManager.ROOT + "categories"
    static let product = ServiceManager.ROOT + "products"
    static let order = ServiceManager.ROOT + "orders"
    static let orderKetThuc = ServiceManager.ROOT + "orders/ketthuc"
    static let bill = ServiceManager.ROOT + "bills"
    static let verify = ServiceManager.ROOT + "user/verify"
}

fileprivate enum ECommonURLs {
    case user
    case table
    case auth
    case checkuser
    case category
    case product
    case order
    case orderDatTruoc
    case orderKetThuc
    case verify
    case bill
    
    
    func getPath() -> String {
        switch self {
        case .user:
            return ListCommonService.user
        case .table:
            return ListCommonService.table
        case .auth:
            return ListCommonService.auth
        case .checkuser:
            return ListCommonService.checkuser
        case .category:
            return ListCommonService.category
        case .product:
            return ListCommonService.product
        case .order:
            return ListCommonService.order
        case .orderDatTruoc:
            return ListCommonService.order + "/dattruoc"
        case .verify:
            return ListCommonService.verify
        case .bill:
            return ListCommonService.bill
        case .orderKetThuc:
            return ListCommonService.orderKetThuc
}
        func getMethod() -> HTTPMethod {
            switch self {
                
            default:
                return.get
            }
        }
    }
}



class CommonServices {
    
    
    func signIn(param: LoginParam?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.auth.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param?.toJSON()) { (success, result, error) in
            if success {
                if result != nil {
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func getUsers(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.user.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil {
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func checkUser(param: PStore?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.checkuser.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param?.toJSON()) { (success, result, error) in
            if success {
                if result != nil {
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func verifyUser(param: PStore?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.verify.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param?.toJSON()) { (success, result, error) in
            if success {
                if result != nil {
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func createUser(param: PStore, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.user.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func updateUSer(param: PStore, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.user.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func deleteUser(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.user.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        print(router)
        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    //table
    func getAllTables(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.table.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func createTable(param: FTable, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.table.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func updateTable(param: FTable, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.table.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func deleteTable(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.table.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    //category
    func getAllCategories(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.category.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func createCategory(param: FCategory, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.category.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func updateCategory(param: FCategory, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.category.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func deleteCategory(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.category.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    
    //product
    func getAllProducts(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.product.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func createProduct(param: FProduct, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.product.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func updateProduct(param: FProduct, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.product.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func deleteProduct(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.product.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    //order
    func getAllOrder(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.order.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func getOneOrder(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.order.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func createOrder(param: FOrder, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.order.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func ketThucOrder(param: FOrder, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.orderKetThuc.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    //
    func createDatTruoc(param: FOrder, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.orderDatTruoc.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func updateOrder(param: FOrder, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.order.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func deleteOrder(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.order.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // bill
    
    func createBill(param: FBill, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.bill.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func getAllBill(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.order.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
//
//
//
//
//    // customer
//    func createCustomer(param: PCustomer, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.customers.getPath()
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getoOneCustomer(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.customers.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getAllCustomers(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.customers.getPath() + (param ?? "")
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        print(router)
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//
//    func updateCustomer(param: PCustomer, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.customers.getPath()
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func deleteCustomer(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.customers.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        print(router)
//        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//
//    //Employee
//    func createEmployee(param: PEmployee, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.employee.getPath()
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getoOneEmployee(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.employee.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getAllEmployees(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.employee.getPath() + (param ?? "")
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//
//    func updateEmployee(param: PEmployee, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.employee.getPath()
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func deleteEmployee(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.employee.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        print(router)
//        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    //book
//    func createBook(param: PBookCalender, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.book.getPath()
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getAllBooks(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//
//
//        let router = ECommonURLs.book.getPath() + (param ?? "")
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getAllBookInSuccess(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//
//
//        let router = ECommonURLs.bookinsuccess.getPath() + (param ?? "")
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getoOneBook(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.book.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//
//    func deleteBook(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.book.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        print(router)
//        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func editBook(param: PBookCalender, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.book.getPath()
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    //services
//
//    func createService(param: PServices, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.service.getPath()
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getoOneServices(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.employee.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func getAllServices(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.service.getPath() + (param ?? "")
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        print(router)
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func updateServices(param: PServices, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.service.getPath()
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    func deleteServices(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.service.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        print(router)
//        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    // bao cao, report
//    func getReport(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
//        let router = ECommonURLs.report.getPath() + "/\(param)"
//        if !ServiceManager.isConnectedToInternet() {
//            completion(nil)
//        }
//        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
//            if success {
//                if result != nil{
//                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
//                        completion(baseResponse)
//                    }
//                }else{
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }
}

