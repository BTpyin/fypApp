//
//  CMSResponse.swift
//  fypApp
//
//  Created by Bowie Tso on 29/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import ObjectMapper

class CMSResponse<T: Mappable>: Mappable {
    
    var success: Bool = false
    var remarks: String?
    var value: T?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        success <- map["Success"]
        remarks  <- map["Remarks"]
        value   <- map["Value"]
    }
}
