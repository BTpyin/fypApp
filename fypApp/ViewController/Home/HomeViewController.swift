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
import FirebaseAuth
import Firebase

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
        guard  let sid = UserDefaults.standard.string(forKey: "studentId") else {
            logout()
            return
        }
        viewModel.getStudent(sid: sid){ [weak self] (failReason) in
            if let tempUser = try? Realm().objects(Student.self){
                Global.user.value = tempUser.first
            }else{
                self?.showErrorAlert(reason: failReason, showCache: true, okClicked: nil)
               }
              print(failReason)

        }
        
        viewModel.syncBeaconList{ [weak self] (failReason) in
         
            if failReason != nil {
              self?.showErrorAlert(reason: failReason, showCache: true, okClicked: nil)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        uiBind(student: Global.user.value)
        self.tableView.reloadData()
        Global.user.asObservable().subscribe(onNext: { student in

            self.uiBind(student: Global.user.value)
            self.tableView.reloadData()
          }).disposed(by: disposeBag)

 
        
        // Do any additional setup after loading the view.
    }
    
    func uiBind(student: Student?){
        displayNameLabel.text = student?.displayName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.getTodayClassArray()?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cellIdentifier = "HomeCourseListTableViewCell"
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeCourseListTableViewCell else {
        fatalError("The dequeued cell is not an instance of HomeCourseListTableViewCell.")
      }
        cell.uiBind(classes: (viewModel.getTodayClassArray()?[indexPath.row]))
        return cell
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        rootRouter?.showTest()
    }
    
    func logout(){
        
        do {
            try Auth.auth().signOut()
        }
             catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
        }
        
        UserDefaults.standard.set("", forKey: "studentId")
        self.navigationController?.popToRootViewController(animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }

}

class HomeViewModel{
    
//    init(){
//        Global.user.value = try? Realm().objects(Student.self).first
//    }

    func getStudent(sid: String,completed: ((SyncDataFailReason?) -> Void)?){
      SyncData().syncStudent(sid: sid, completed: completed)
    }
    
    func syncBeaconList(completed: ((SyncDataFailReason?) -> Void)?){
        SyncData().syncBeacons(completed: completed)
    }
    
    func getTodayClassArray() -> [Class]?{
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date().endOfDay()
        let tdyPredicate = NSPredicate(format:  "(date >= %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
        return Global.user.value?.courseTaking.filter({($0.date! >= startDate && $0.date! <= endDate)})
    }
}
