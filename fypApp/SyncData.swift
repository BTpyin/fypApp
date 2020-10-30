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
                realm.add(student)
            }, completed:{
                completed?(nil)
              })
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
            let reason = self.failReason(error: error, resposne: resposne)
//            SyncData.writeRealmAsync({ (realm) in
//              realm.delete(realm.objects(Student.self))
//                realm.add(Student().demoStudent())
//                
//            }, completed:{
//                completed?(nil)
//              })
            completed?(nil)
            
          })
        Global.user.value = Student().demoStudent()
        
    }
    
    func syncCourseDetail(courseId:String, completed:((SyncDataFailReason?) -> Void)?) {
        Api().getCourseDetail(courseId: courseId, success: {(response) in
            guard let course = response else {
                completed?(nil)
                return
            }
            SyncData.writeRealmAsync({ (realm) in
              realm.delete(realm.objects(Course.self))
                realm.add(course)
            }, completed:{
                completed?(nil)
              })
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
            let reason = self.failReason(error: error, resposne: resposne)
        })
    }
    
    func syncClassroomInfo(classroomId:String, completed:((SyncDataFailReason?) -> Void)?) {
        Api().getClassroomInfo(classroomId: classroomId, success: {(response) in
            guard let classroom = response else {
                completed?(nil)
                return
            }
            SyncData.writeRealmAsync({ (realm) in
              realm.delete(realm.objects(Classroom.self))
                realm.add(classroom)
            }, completed:{
                completed?(nil)
              })
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
            let reason = self.failReason(error: error, resposne: resposne)
        })
    }
    
    func syncClassInfo(classId:String, completed:((SyncDataFailReason?) -> Void)?) {
        Api().getClassInfo(classId: classId, success: {(response) in
            guard let classObj = response else {
                completed?(nil)
                return
            }
            SyncData.writeRealmAsync({ (realm) in
//              realm.delete(realm.objects(Classroom.self))
                realm.add(classObj)
            }, completed:{
                completed?(nil)
              })
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
            let reason = self.failReason(error: error, resposne: resposne)
        })
    }
    
    func updateDisplayName(sid: String, name: String, completed:((SyncDataFailReason?) -> Void)?) {
        Api().updateDisplayName(name: name, sid: sid, success: {(response) in
            guard let student = response else {
                completed?(nil)
                return
            }
            SyncData.writeRealmAsync({ (realm) in
              realm.delete(realm.objects(Student.self))
                realm.add(student)
            }, completed:{
                completed?(nil)
              })
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
            let reason = self.failReason(error: error, resposne: resposne)
//            SyncData.writeRealmAsync({ (realm) in
//              realm.delete(realm.objects(Student.self))
//                realm.add(Student().demoStudent())
//
//            }, completed:{
//                completed?(nil)
//              })
            completed?(nil)
            
          })
        Global.user.value = Student().demoStudent()
    }
    
    func syncBeacons(completed:((SyncDataFailReason?) -> Void)?) {
        Api().getBeaconRepresent(success: {(beaconPayload) in
            guard let beacons = beaconPayload?.beaconList else {
                completed?(nil)
                return
            }
            SyncData.writeRealmAsync({ (realm) in
              realm.delete(realm.objects(Beacon.self))
                realm.add(beacons)
            }, completed:{
                completed?(nil)
              })
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
            let reason = self.failReason(error: error, resposne: resposne)

            completed?(reason)
            
          })

    
}
    
    
}
