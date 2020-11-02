//
//  Api.swift
//  fypApp
//
//  Created by Bowie Tso on 29/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class Api {
//  static let requestBasePath = "http://192.168.0.102:8000/catalog/api/"
    static let requestBasePath = "http://175.159.83.218:8000/catalog/api/"
    
//  static let ReceiveApiErrorNotification = NSNotification.Name.init("ReceiveApiErrorNotification")
//  static let ErrorCodeRemoteSignout = 214
//  static let ErrorCodeMaintanceMode = 1001

//  lazy var sessionManager = SessionManager.shared
  
  // MARK: - Common
  func stopAllRunningRequest() {
    Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
      tasks.forEach({ $0.cancel() })
    }
  }
    func get<U>(_ path: String,
                responseClass: CMSResponse<U>.Type,
                parameters: Parameters = Parameters(),
                success: @escaping (_ payload: U?) -> Void,
                fail: @escaping (_ errr: Error?, _ response: CMSResponse<U>?) -> Void ) {
      
      var param = parameters
//      if tokenNeeded {
//        param["token"] = sessionManager.userToken
//      }
      Alamofire.request(path, method: .get, parameters: param)
        .responseObject { (response: DataResponse<CMSResponse<U>>) in
//          #if DEVELOPMENT
            print("🌏 Success: \(response.result.isSuccess)" +
                    "Request \(String(describing: response.request?.url)) " +
              "Err: \(String(describing: response.error)) ")
//          #endif
          
          if response.result.isSuccess {
            let responseObject = response.result.value
            
            if responseObject?.success ?? false {
                success(responseObject?.value)
            }
//            else {
//
//              if responseObject?.errorCode == Api.ErrorCodeRemoteSignout {
//                // Handle ErrorCode: 214 Device Remote Signout
//                NotificationCenter.default.post(name: Api.ReceiveApiErrorNotification,
//                                                object: ["errorCode": Api.ErrorCodeRemoteSignout,
//                                                         "response": responseObject])
//              } else if responseObject?.errorCode == Api.ErrorCodeMaintanceMode {
//                // Parse as Maintance Mode resposne
//                if let jsonData = response.data,
//                  let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8) {
//                  let maintainceModeResposne = VTCResponse<MaintanceModePayload>(JSONString: jsonString)
//
//                  NotificationCenter.default.post(name: Api.ReceiveApiErrorNotification,
//                                                  object: ["errorCode": Api.ErrorCodeMaintanceMode,
//                                                           "response": maintainceModeResposne])
//                }
//              }
              else {
                fail(nil, responseObject)
              
            }
          } else {
            fail(response.error, response.result.value)  // E.g. No Network
          }
      }
    }
    
    func post<U, T: CMSResponse<U>>(_ path: String,
                                    responseClass: T.Type,
                                    parameters: Parameters?,
                                    success: @escaping (_ payload: U?) -> Void,
                                    fail: @escaping (_ errr: Error?, _ response: T? ) -> Void ) {
      
      Alamofire.request(path, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default)
        .responseObject { (response: DataResponse<T>) in
//          #if DEVELOPMENT
          print("🌏 Success: \(response.result.isSuccess)" +
              "Request \(String(describing: response.request?.url)) " +
              "Err: \(String(describing: response.error)) ")
//          #endif
          
          if response.result.isSuccess {
            let responseObject: T? = response.result.value
            
            if responseObject?.success ?? false {
              success(responseObject?.value)
            } else {
              fail(nil, responseObject)
            }
          } else {
            fail(response.error, response.result.value)  // E.g. No Network
          }
      }
    }
    
    func updateDisplayName(name:String, sid: String, success: @escaping (_ payload: Student?) -> Void,
                           fail: @escaping (_ error: Error?, CMSResponse<Student>?) -> Void) {
        var postBody = Parameters()
        postBody["display_name"] = name
            post("\(Api.requestBasePath)updateDisplayName/\(sid)",
                responseClass: CMSResponse<Student>.self, parameters: postBody,
                success: success, fail: fail
            )
    }
    
    func getStudentInfo(sid:String, success: @escaping (_ payload: Student?) -> Void,
                        fail: @escaping (_ error: Error?, CMSResponse<Student>?) -> Void) {
         get("\(Api.requestBasePath)getStudentInfo/\(sid)",
           responseClass: CMSResponse<Student>.self,
           success: success, fail: fail
         )
    }
    
    func getCourseDetail(courseId:String, success: @escaping (_ payload: Course?) -> Void,
                         fail: @escaping (_ error: Error?, CMSResponse<Course>?) -> Void){
        get("\(Api.requestBasePath)getCourseDetail\(courseId)",
          responseClass: CMSResponse<Course>.self,
          success: success, fail: fail
        )
    }
    
    func getClassroomInfo(classroomId:String, success: @escaping (_ payload: Classroom?) -> Void,
                          fail: @escaping (_ error: Error?, CMSResponse<Classroom>?) -> Void){
        get("\(Api.requestBasePath)getClassroomInfo\(classroomId)",
          responseClass: CMSResponse<Classroom>.self,
          success: success, fail: fail
        )
    }
    
    func getClassInfo(classId:String, success: @escaping (_ payload: Class?) -> Void,
                      fail: @escaping (_ error: Error?, CMSResponse<Class>?) -> Void){
            get("\(Api.requestBasePath)getClassInfo/?classId=\(classId)",
            responseClass: CMSResponse<Class>.self,
            success: success, fail: fail
            )
}
    
    func getBeaconRepresent(success: @escaping (_ payload: BeaconPayload?) -> Void,
                          fail: @escaping (_ error: Error?, CMSResponse<BeaconPayload>?) -> Void){
        get("\(Api.requestBasePath)getBeaconRepresent",
                  responseClass: CMSResponse<BeaconPayload>.self,
                  success: success, fail: fail)
    }
    
    func takeAttendance(classroomId:String, sid: String, success: @escaping (_ payload: AttendanceResponse?) -> Void,
                           fail: @escaping (_ error: Error?, CMSResponse<AttendanceResponse>?) -> Void) {
        var postBody = Parameters()
        postBody["sid"] = sid
            post("\(Api.requestBasePath)takeAttendance/\(classroomId)",
                responseClass: CMSResponse<AttendanceResponse>.self, parameters: postBody,
                success: success, fail: fail
            )
    }
    
    func checkSidValid(sid:String, success: @escaping (_ payload: SidValid?) -> Void,
                       fail: @escaping (_ error: Error?, CMSResponse<SidValid>?) -> Void) {
        get("\(Api.requestBasePath)checkSidValid/?sid=\(sid)",
          responseClass: CMSResponse<SidValid>.self,
          success: success, fail: fail
        )
   }
    
}
