//
//  AttendanceViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift
import RxRealm
import RxSwift

class AttendanceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    var viewModel: AttendanceViewModel?
    var disposeBag = DisposeBag()
    var locationManager : CLLocationManager?
    var helper = BeaconHelper()
    
    @IBOutlet weak var beachSearchButton: UIButton!
    @IBOutlet weak var beaconIndicatorView: UIView!
    @IBOutlet weak var beaconIndicatorLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager = helper.locationManager
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        viewModel = AttendanceViewModel()
        //monitorBeacons()
        uiBind()
        viewModel?.segmentValue.asObservable().subscribe(onNext: { segmentValue in
            self.viewModel?.fetchAttendanceRecordFromRealm()
            if segmentValue {
                self.viewModel?.startSearching.value = true
                self.beaconIndicatorView.isHidden = false
            }
            else{
                self.viewModel?.startSearching.value = false
                self.beaconIndicatorView.isHidden = true
            }
            self.tableView.reloadData()
            

          }).disposed(by: disposeBag)
        
        viewModel?.startSearching.asObservable().subscribe(onNext: {indicator in
            if indicator {
                self.beachSearchButton.setTitle("Stop Searching", for: .normal)
                self.beachSearchButton.backgroundColor = UIColor.init(red: 255, green: 69, blue: 58)
                self.helper.monitorBeacons()
            }else{
                self.beachSearchButton.setTitle("Start Searching", for: .normal)
                self.beachSearchButton.backgroundColor = UIColor.init(red: 50, green: 215, blue: 75)
                self.helper.stopMonitorBeacon()
            }
        }).disposed(by:disposeBag)
        
        viewModel?.fetchBeaconListFromRealm()
        viewModel?.fetchAttendanceRecordFromRealm()
        //searchBeacon Algo
        
        
        
        //After Gettingt Beacons and stroed in viewModel
//        viewModel?.makeDemoBeaconList()
        
        //Using Demo Beacons Generated in code
        
//        guard let beaconList = viewModel?.demoDetectedBeaconList.value else {
//            self.showAlert("No Classroom detected")
//            return
//        }
        
//        viewModel?.detecedClassList?.value.removeAll()
//
//        for searchedBeacon in beaconList {
//            let classroomId = (viewModel?.retreiveBeacontoClassroomID(major: searchedBeacon.major!, minor: searchedBeacon.minor!))!
//            guard let searchedClass = (viewModel?.findClassInStudent(classroomId: classroomId)) else{
////                self.showAlert("Detected Beacon Cannot Match with any Classroom")
//                continue
//            }
//            viewModel?.getClassFromCMSforDetectClass(classId: ((viewModel?.findClassInStudent(classroomId: classroomId))?.classId)!){[weak self] (failReason) in
//
//            }
//        }

        //observables for the lists
        viewModel?.detectedBeaconList?.asObservable().subscribe(onNext: { beacon in
            self.viewModel?.tempClassList.removeAll()
            guard let beaconList = self.viewModel?.detectedBeaconList?.value else {
                        self.showAlert("No Classroom detected")
                        return
                    }
//            if (self.viewModel?.detectedBeaconList?.value.count)! > 0{
//                self.stopMonitorBeacon()
//
//            }
            for searchedBeacon in beaconList{
                let classroomId = (self.viewModel?.retreiveBeacontoClassroomID(major: searchedBeacon.major.stringValue, minor: searchedBeacon.minor.stringValue))!
                guard let searchedClass = (self.viewModel?.findClassInStudent(classroomId: classroomId)) else{
    //                self.showAlert("Detected Beacon Cannot Match with any Classroom")
                    continue
                }
                self.viewModel?.getClassFromCMSforDetectClass(classId: ((self.viewModel?.findClassInStudent(classroomId: classroomId))?.classId)!){[weak self] (failReason) in
//                    self?.tableView.reloadData()
                }
            }
//            self.viewModel?.detecedClassList?.value = self.viewModel!.tempClassList
            self.beaconIndicatorLabel.text = "nill    " + (self.viewModel?.detecedClassList?.value.first?.classId ?? "nothing")

        }).disposed(by: disposeBag)
        
        
        viewModel?.detecedClassList?.asObservable().subscribe(onNext: { classValue in
            if (self.viewModel?.detecedClassList?.value.count)! > 0 {
                self.helper.stopMonitorBeacon()
            }
            self.tableView.reloadData()
          }).disposed(by: disposeBag)

        //Mark: for handle attended class record
        
        viewModel?.attendedClass?.asObservable().subscribe(onNext: { classValue in

            self.tableView.reloadData()
          }).disposed(by: disposeBag)
        
        Observable.arrayWithChangeset(from: (viewModel?.attendanceRecord)!)
          .subscribe(onNext: { array, changes in
            if let changes = changes {
            // it's an update
                self.viewModel?.attendedClass?.value.removeAll()
                for record in (self.viewModel?.getAttendanceRecordToArray())!{
                    self.viewModel?.getClassFromCMSforAttendanceRecord(classId: record.classId!, completed: {[weak self] (failReason) in

                    })

                }
          } else {
            // it's the initial data
//            print(array)
//            below is just for testing adjust the value that first added
            self.viewModel?.attendedClass?.value.removeAll()
            for record in (self.viewModel?.getAttendanceRecordToArray())!{
                self.viewModel?.getClassFromCMSforAttendanceRecord(classId: record.classId!, completed: {[weak self] (failReason) in

                })

            }
          }
          })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentControlAction(_ sender: Any) {
        viewModel?.segmentValue.value.toggle()
        
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        viewModel?.startSearching.value.toggle()
    }
    
    func uiBind(){
        beaconIndicatorView.layer.applySketchShadow(
            color: .black,
            alpha: 0.4,
            x: 0,
              y: 0.5,
            blur: 6,
              spread: 0)
        beachSearchButton.roundCorners(cornerRadius: 10)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        // 開始偵測範圍之後，就先檢查目前的 state 是否在範圍內
        manager.requestState(for: region)
    }

    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        guard region is CLBeaconRegion else { return }

        if state == .inside { // 在範圍內
            if CLLocationManager.isRangingAvailable() {
                manager.startRangingBeacons(in: region as! CLBeaconRegion)
            }
        } else if state == .outside { // 在範圍外
            if CLLocationManager.isRangingAvailable() {
                manager.stopRangingBeacons(in: region as! CLBeaconRegion)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        var beaconList = [CLBeacon]()
        for beacon in beacons{
            if (beacon.proximity == .immediate ){
             //adding beacon that in near and immediate range to detected Beacon List
                beaconList.append(beacon)
            }
        }
        viewModel?.detectedBeaconList?.value = beaconList
        if beacons.count == 0{
            viewModel?.detecedClassList?.value.removeAll()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter region")
//        beaconIndicatorLabel.text="enter region"
        if CLLocationManager.isRangingAvailable() {
            locationManager?.startRangingBeacons(in: region as! CLBeaconRegion)
        }
    }
     func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exit region")
//        beaconIndicatorLabel.text="exit region"
        locationManager?.stopRangingBeacons(in: region as! CLBeaconRegion)
     }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
        if (viewModel?.segmentValue.value == true){
            let controller = UIAlertController(title: "Take Attendance", message: "Take Attendance in \(((viewModel?.detecedClassList?.value[indexPath.row])?.classroom?.classroomId)!)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                
                self.viewModel?.takeAttendanceToCMS(classId: (self.viewModel?.detecedClassList?.value[indexPath.row].classId)!, classroomId: (self.viewModel?.detecedClassList?.value[indexPath.row].classroomId)!){[weak self] (failReason) in
                    if failReason != nil{
                        print(failReason)
                    }
                }

            }
            controller.addAction(okAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel?.segmentValue.value == true){
            return viewModel?.detecedClassList?.value.count ?? 0
            
        }else{
            return viewModel?.getAttendanceRecordToArray().count ?? 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (viewModel?.segmentValue.value == true){
            let cellIdentifier = "AttendanceTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AttendanceTableViewCell else {
              fatalError("The dequeued cell is not an instance of AttendanceTableViewCell.")
            }
            cell.uiBind(classObj: (viewModel?.detecedClassList?.value[indexPath.row])!)
              return cell
        }else {
            let cellIdentifier = "AttendanceRecordTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AttendanceRecordTableViewCell else {
              fatalError("The dequeued cell is not an instance of AttendanceRecordTableViewCell.")
            }
            
            cell.uiBind(classObj: (viewModel?.attendedClass?.value[indexPath.row])!)
            
            
              return cell
        }

    }

}



class AttendanceViewModel{
    var segmentValue : Variable<Bool> = Variable<Bool>(true)
    var startSearching : Variable<Bool> = Variable<Bool>(true)
    var beaconList: Results<Beacon>?
    var attendanceRecord: Results<Attendance>?
    var demoDetectedBeaconList: Variable<[Beacon]> = Variable<[Beacon]>([])
    var detecedClassList:Variable<[Class]>? = Variable<[Class]>([])
    var attendedClass: Variable<[Class]>? = Variable<[Class]>([])
    var detectedBeaconList : Variable<[CLBeacon]>? = Variable<[CLBeacon]>([])
    var tempClass = Class()
    var tempClassList = [Class]([])
    
    func syncClass(classId: String,completed: ((SyncDataFailReason?) -> Void)?){
        SyncData().syncClassInfo(classId: classId, completed: completed)
      }

    func getClassFromCMSforDetectClass(classId:String, completed: ((SyncDataFailReason?) -> Void)?){
        Api().getClassInfo(classId: classId, success: {(response) in
            guard let classObj = response else {
                completed?(nil)
                return
            }
            if self.detecedClassList?.value.count == 0{
                self.detecedClassList?.value.append(classObj)
                
            }else{
                self.detecedClassList?.value[0] = classObj
            }
//            print("detecedClassList: \n", self.detecedClassList?.value)
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
//            let reason = self.failReason(error: error, resposne: resposne)
        })
    }
    
    func getClassFromCMSforAttendanceRecord(classId:String, completed: ((SyncDataFailReason?) -> Void)?){
        Api().getClassInfo(classId: classId, success: {(response) in
            guard let classObj = response else {
                completed?(nil)
                return
            }
//            self.tempClass = classObj
            self.attendedClass?.value.append(classObj)
//            print("detecedClassList: \n", self.detecedClassList?.value)
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
//            let reason = self.failReason(error: error, resposne: resposne)
            self.tempClass = Class()
        })
    }
    
    func makeDemoBeaconList(){
        var list = [Beacon]()
//        print((beaconList?.toArray())!)
        list = (beaconList?.toArray())!

        demoDetectedBeaconList.value.append(Beacon().demoBeacon(major: "4", minor: "3", classroomId: "B4302"))
        demoDetectedBeaconList.value.append(Beacon().demoBeacon(major: "5", minor: "5", classroomId: "LT-1"))
    }
    
    func retreiveBeacontoClassroomID(major: String, minor: String) -> String{
        let predicate = NSPredicate(format: "major = %@ AND minor = %@", major, minor)
        let classrromId = ((try? Realm().objects(Beacon.self).filter(predicate).first)?.classroomId) ?? ""
        return classrromId
    }
    
    func findClassInStudent(classroomId: String) -> Class?{
        let semClassList = Global.user.value?.courseTaking
        //print(semClassList)
        let classroomPredicate = NSPredicate(format: "classroom.classroomId = %@", classroomId)
        let filteredClassListByVenue = semClassList?.filter(classroomPredicate)
//        print(filteredClassListByVenue)
        let startDate = (Calendar.current.date(byAdding: .minute, value: -10, to: Date()))!
        let endDate = (Calendar.current.date(byAdding: .minute, value: 20, to: Date()))!
        let timePredicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
//        filteredClassListByVenue?.filter(timePredicate)
//        print((semClassList?.filter(classroomPredicate).first)!)
//        print(filteredClassListByVenue?.filter(timePredicate))
        return (filteredClassListByVenue?.filter(timePredicate).first)
    }
    
    func takeAttendanceToCMS(classId : String, classroomId:String, completed: ((SyncDataFailReason?) -> Void)?){
        SyncData().takeAttendance(classId: classId, classroomId: classroomId, sid: (Global.user
                                                                    .value?.studentId)!, completed: completed)
    }
    
    func fetchAttendanceRecordFromRealm(){
        attendanceRecord = try? Realm().objects(Attendance.self)
    }
    
    func fetchBeaconListFromRealm(){
        beaconList = try? Realm().objects(Beacon.self)
        makeDemoBeaconList()
    }
    
    func getAttendanceRecordToArray()->[Attendance]{
        print(attendanceRecord?.toArray())
        return (attendanceRecord?.toArray() ?? [Attendance]())
    }
}


struct MajorMinor {
    var major : String?
    var minor : String?
    
    init(major:String , minor:String) {
        self.major = major
        self.minor = minor
    }
}

