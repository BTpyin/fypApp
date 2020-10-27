//
//  HomeViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 14/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var helloView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var displayNameLabel: UILabel!
    
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    
    var disposeBag = DisposeBag()
    var viewModel  = HomeViewModel()
//    override func viewDidLayoutSubviews() {
//       super.viewDidLayoutSubviews()
//      scrollView.contentSize = CGSize(width: scrollView.frame.width, height: (helloView.frame.height + tableView.frame.height) )
//
//    }
    override func loadView() {
        super.loadView()
        viewModel.getStudent(sid: UserDefaults.standard.string(forKey: "studentId")!){ [weak self] (failReason) in
            if let tempUser = try? Realm().objects(Student.self){
                Global.user.value = tempUser.first
            }else{
                self?.showErrorAlert(reason: failReason, showCache: true, okClicked: nil)
               }
              print(failReason)

        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        uiBind(student: Global.user.value)
        
        Global.user.asObservable().subscribe(onNext: { student in

            self.uiBind(student: Global.user.value)
          }).disposed(by: disposeBag)

 
        
        // Do any additional setup after loading the view.
    }
    
    func uiBind(student: Student?){
        displayNameLabel.text = student?.displayName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cellIdentifier = "HomeCourseListTableViewCell"
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeCourseListTableViewCell else {
        fatalError("The dequeued cell is not an instance of HomeCourseListTableViewCell.")
      }
        return cell
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        rootRouter?.showTest()
    }

}

class HomeViewModel{
    
//    init(){
//        Global.user.value = try? Realm().objects(Student.self).first
//    }

    func getStudent(sid: String,completed: ((SyncDataFailReason?) -> Void)?){
      SyncData().syncStudent(sid: sid, completed: completed)
    }
}
