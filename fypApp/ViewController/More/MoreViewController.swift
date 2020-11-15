//
//  MoreViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseAuth
import Firebase

class MoreViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    var viewModel : MoreViewModel?
    @IBOutlet weak var tableView: UITableView!
    
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    
    var moreRouter : MoreRouter?{
        return router as? MoreRouter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoreViewModel()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.row == 0){
            rootRouter?.showProfile()
        }else if(indexPath.row == 2){
            let controller = UIAlertController(title: "Confirm Logout?", message: "Attendance Record that stored in local will be removed and will not be Recovered. (Teachers and Admin still be able to seethe record in server)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                self.logout()

            }
            controller.addAction(okAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
            
        }else if(indexPath.row == 3){
            let controller = UIAlertController(title: "Confirm Reset Password?", message: "Attendance Record that stored in local will be removed and will not be Recovered. (Teachers and Admin still be able to seethe record in server)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                self.rootRouter?.showReset()
            }
            controller.addAction(okAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.settingContentList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cellIdentifier = "SettingTableViewCell"
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SettingTableViewCell else {
        fatalError("The dequeued cell is not an instance of SettingTableViewCell.")
      }
        cell.settingLabel.text = viewModel?.settingContentList[indexPath.row]
        return cell
    }
    
    func logout(){
        
        do {
            try Auth.auth().signOut()
        }
             catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
        }
        
        UserDefaults.standard.set("", forKey: "studentId")
//        SyncData.writeRealmAsync({ (realm) in
//            realm.delete(realm.objects(Student.self))
//            realm.delete(realm.objects(Attendance.self))
//        }, completed:{
//          })
        self.navigationController?.popToRootViewController(animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }


}

class MoreViewModel{
    var settingContentList = ["Profile","Terms","Logout","Reset Password"]
}
