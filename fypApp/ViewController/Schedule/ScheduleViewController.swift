//
//  ScheduleViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import Kingfisher

class ScheduleViewController: BaseViewController {

    @IBOutlet weak var scheduleImageView: UIImageView!
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        Global.user.asObservable().subscribe(onNext: { student in
            
            self.uiBind(student: Global.user.value!)
          }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
    func uiBind(student: Student){
        scheduleImageView.kf.setImage(with: URL(string: student.scheduleLink!))
    }

}
