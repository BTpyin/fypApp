//
//  Global.swift
//  fypApp
//
//  Created by Bowie Tso on 6/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
class Global{
    static var user = Variable<Student?>(nil)
    static var beaconUUID = "10fa751d-3bdc-44f1-8367-f1572c73e5a9"
}
