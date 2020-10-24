//
//  SIdValid.swift
//  fypApp
//
//  Created by Bowie Tso on 24/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//


import Foundation
import RealmSwift
import ObjectMapper

class SidValid: Object, Mappable{
    
    @objc dynamic var valid : Bool = false
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        valid <- map["Valid"]

        
    }
    
    
}
