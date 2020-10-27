//
//  MoreViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
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
                logout()
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
        self.navigationController?.popToRootViewController(animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }


}

class MoreViewModel{
    var settingContentList = ["Profile","Terms","Logout"]
}
