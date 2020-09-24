//
//  MoreViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

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


}

class MoreViewModel{
    var settingContentList = ["Profile","Terms","Logout"]
}
