//
//  HomeCourseListTableViewCell.swift
//  fypApp
//
//  Created by Bowie Tso on 22/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class HomeCourseListTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBaseView: UIView!
    @IBOutlet weak var topLayerView: UIView!
    @IBOutlet weak var courseCodeLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBaseView.roundCorners(cornerRadius: 20)
//        cellBaseView.layer.applySketchShadow(
//            color: .black,
//            alpha: 0.4,
//            x: 2,
//            y: 2,
//            blur: 2,
//              spread: 0)
        cellBaseView.layer.shadowOffset = CGSize(width: 2, height: 5)
        cellBaseView.layer.shadowColor = UIColor.init(white: 101/255, alpha: 1.0).cgColor
        cellBaseView.layer.shadowOpacity = 0.5
        cellBaseView.layer.masksToBounds = false
        // Initialization code
        cellBaseView.layer.shadowRadius = 5 / 2.0
        cellBaseView.roundCorners(cornerRadius: 20)
        
    }

    func uiBind(classes : Class?){
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        dateLabel.text = dateFormatterPrint.string(from: classes?.date ?? Date())
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        timeLabel.text  = dateFormatterTime.string(from: classes?.date ?? Date())
//        dateLabel.text = classes.date
        let durationFormatter = DateFormatter()
        durationFormatter.dateFormat = "HH 'hour(s)' mm 'mins'"
        durationLabel.text = durationFormatter.string(from: classes?.duration ?? Date())
        courseCodeLabel.text = classes?.course?.courseCode
        courseNameLabel.text = ((classes?.course?.name ?? "") + "\n" + (classes?.name ?? ""))
        venueLabel.text = classes?.classroom?.classroomId
    }

}
