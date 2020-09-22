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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBaseView.roundCorners(cornerRadius: 20)
        cellBaseView.layer.shadowOffset = CGSize(width: 2, height: 5)
        cellBaseView.layer.shadowColor = UIColor.init(white: 191/255, alpha: 1.0).cgColor
        cellBaseView.layer.shadowOpacity = 0.5
        // Initialization code
        
    }

    func uiBind(class : Class){
        
        
    }

}
