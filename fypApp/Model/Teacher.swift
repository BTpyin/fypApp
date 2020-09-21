//
//  Teacher.swift
//  fypApp
//
//  Created by Bowie Tso on 21/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Teacher: Object, Mappable{
    
    @objc dynamic var teacherId: String?
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var displayName : String?
    @objc dynamic var department : String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        teacherId <- map["teacherId"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        displayName <- map["displayName"]
        department <- map["department"]
        
    }
    
    
}
