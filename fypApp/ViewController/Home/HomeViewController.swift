//
//  HomeViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 14/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var helloView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    
//    override func viewDidLayoutSubviews() {
//       super.viewDidLayoutSubviews()
//      scrollView.contentSize = CGSize(width: scrollView.frame.width, height: (helloView.frame.height + tableView.frame.height) )
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

 
        
        // Do any additional setup after loading the view.
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
