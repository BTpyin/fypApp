//
//  AttendanceTableViewCell.swift
//  fypApp
//
//  Created by Bowie Tso on 28/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var courseCodeLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.layer.applySketchShadow(
                    color: .black,
                    alpha: 0.3,
                    x: 1,
                    y: 0,
                    blur: 3,
                      spread: 0)
        // Initialization code
    }
    
    func uiBind(classObj: Class){
        courseNameLabel.text = ((classObj.course?.name ?? "" ) + "\n" + (classObj.name)!)
        courseCodeLabel.text = classObj.course?.courseCode
        locationLabel.text = classObj.classroom?.classroomId
//        print(classObj)
    }



}
