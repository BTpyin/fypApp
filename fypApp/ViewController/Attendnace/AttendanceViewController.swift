//
//  AttendanceViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
import RxSwift

class AttendanceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    var viewModel: AttendanceViewModel?
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = AttendanceViewModel()
        viewModel?.segmentValue.asObservable().subscribe(onNext: { segmentValue in
            self.tableView.reloadData()
            

          }).disposed(by: disposeBag)
        
        
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentControlAction(_ sender: Any) {
        viewModel?.segmentValue.value.toggle()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (viewModel?.segmentValue.value == true){
            let cellIdentifier = "AttendanceTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AttendanceTableViewCell else {
              fatalError("The dequeued cell is not an instance of AttendanceTableViewCell.")
            }
              return cell
        }else {
            let cellIdentifier = "AttendanceRecordTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AttendanceRecordTableViewCell else {
              fatalError("The dequeued cell is not an instance of AttendanceRecordTableViewCell.")
            }
              return cell
        }

    }

}

class AttendanceViewModel{
    var segmentValue : Variable<Bool> = Variable<Bool>(true)
}
