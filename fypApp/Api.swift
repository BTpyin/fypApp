////
////  Api.swift
////  fypApp
////
////  Created by Bowie Tso on 29/9/2020.
////  Copyright © 2020 Bowie Tso. All rights reserved.
////
//
//import Foundation
//import Alamofire
//import AlamofireObjectMapper
//import ObjectMapper
//
//class Api {
//  static let requestBasePath = "http://127.0.0.1:8000/catalog/api"
//
////  static let ReceiveApiErrorNotification = NSNotification.Name.init("ReceiveApiErrorNotification")
////  static let ErrorCodeRemoteSignout = 214
////  static let ErrorCodeMaintanceMode = 1001
//
////  lazy var sessionManager = SessionManager.shared
//  
//  // MARK: - Common
//  func stopAllRunningRequest() {
//    Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
//      tasks.forEach({ $0.cancel() })
//    }
//  }
//  
//  func get<U>(_ path: String,
//              responseClass: CMSResponse<U>.Type,
//              parameters: Parameters = Parameters(),
//              success: @escaping (_ payload: U?) -> Void,
//              fail: @escaping (_ errr: Error?, _ response: CMSResponse<U>?) -> Void ) {
//    
//    var param = parameters
////    if tokenNeeded {
////      param["token"] = sessionManager.userToken
////    }
//    Alamofire.request(path, method: .get, parameters: param)
//      .responseObject { (response: DataResponse<CMSResponse<U>>) in
//        #if DEVELOPMENT
//          print("🌏 Success: \(response.result.success)" +
//            "Request \(String(describing: response.request?.url)) " +
//            "Err: \(String(describing: response.error)) ")
//        #endif
//        
////        if response.result.success {
////          let responseObject = response.result.value
////
////          if responseObject?.success ?? false {
////            success(responseObject?.value)
////          } else {
////              fail(nil, responseObject)
////            }
////          }
////        } else {
////          fail(response.error, response.result.value)  // E.g. No Network
////        }
//    }
//  }
//  
//  func post<U, T: CMSResponse<U>>(_ path: String,
//                                  responseClass: T.Type,
//                                  parameters: Parameters?,
//                                  success: @escaping (_ payload: U?) -> Void,
//                                  fail: @escaping (_ errr: Error?, _ response: T? ) -> Void ) {
//    
//    Alamofire.request(path, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default)
//      .responseObject { (response: DataResponse<T>) in
//        #if DEVELOPMENT
//          print("🌏 Success: \(response.result.isSuccess)" +
//            "Request \(String(describing: response.request?.url)) " +
//            "Err: \(String(describing: response.error)) ")
//        #endif
//        
//        if response.result.isSuccess {
//          let responseObject: T? = response.result.value
//          
//          if responseObject?.success ?? false {
//            success(responseObject?.value)
//          } else {
//            fail(nil, responseObject)
//          }
//        } else {
//          fail(response.error, response.result.value)  // E.g. No Network
//        }
//    }
//  }
//}
