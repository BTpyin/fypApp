//
//  SyncData.swift
//  fypApp
//
//  Created by Bowie Tso on 29/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

enum SyncDataFailReason: Error {
  case network
  case realmWrite
  case other
}


class SyncData {
    static var firstSync : Bool  = false
    
    static var realmBackgroundQueue = DispatchQueue(label: ".realm", qos: .background)
    
    static func writeRealmAsync(_ write: @escaping (_ realm: Realm) -> Void,
                                completed: (() -> Void)? = nil) {
      SyncData.realmBackgroundQueue.async {
        autoreleasepool {
          do {
            let realm = try Realm()
            realm.beginWrite()
            write(realm)
            try realm.commitWrite()

            if let completed = completed {
              DispatchQueue.main.async {
                let mainThreadRealm = try? Realm()
                mainThreadRealm?.refresh() // Get updateds from Background thread
                completed()
              }
            }



          } catch {
            print("writeRealmAsync Exception \(error)")
          }
        }
      }
    }
    
    func failReason(error: Error?, resposne: Any?) -> SyncDataFailReason {
      if let error = error as NSError?, error.domain == NSURLErrorDomain {
        return .network
      }
      return .other
    }
    
    func syncStudent(sid: String, completed:((SyncDataFailReason?) -> Void)?) {
        Api().getStudentInfo(sid: sid, success: {(response) in
            guard let student = response else {
                completed?(nil)
                return
            }
            SyncData.writeRealmAsync({ (realm) in
              realm.delete(realm.objects(Student.self))
                realm.add(Student().demoStudent())
            }, completed:{
                completed?(nil)
              })
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
            let reason = self.failReason(error: error, resposne: resposne)
            SyncData.writeRealmAsync({ (realm) in
              realm.delete(realm.objects(Student.self))
                realm.add(Student().demoStudent())
                
            }, completed:{
                completed?(nil)
              })
            completed?(nil)
            
          })
        Global.user.value = Student().demoStudent()
        
    }
}
