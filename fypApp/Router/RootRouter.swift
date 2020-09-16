//
//  RootRouter.swift
//  fypApp
//
//  Created by Bowie Tso on 14/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//
import UIKit

class RootRouter: Router{

    func showStart(animated: Bool, complete: (() -> Void)? = nil ){
        guard
          let homeViewController = UIStoryboard.storyboard(.main).instantiateViewController(HomeViewController.self) else {
            return
        }
        //        let homeNavigationController = BaseNavigationController.init(rootViewController: homeViewController)
        homeViewController.router = self
        //navigationController?.setNavigationBarHidden(true, animated: animated)
        homeViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(homeViewController, animated: false)
    }

    func showTest(){
        guard
            let testViewController = UIStoryboard.storyboard(.main).instantiateViewController(TestViewController.self) else {
              return
          }
          
        testViewController.router = self
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.pushViewController(testViewController, animated: true)
    }
    
    func showSchedule(){
        guard
          let scheduleViewController = UIStoryboard.storyboard(.main).instantiateViewController(ScheduleViewController.self) else {
            return
        }
        //        let homeNavigationController = BaseNavigationController.init(rootViewController: homeViewController)
        scheduleViewController.router = self
        //navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(scheduleViewController, animated: false)
    }
    
    func showMore(){
        guard
          let moreViewController = UIStoryboard.storyboard(.more).instantiateViewController(MoreViewController.self) else {
            return
        }
        //        let homeNavigationController = BaseNavigationController.init(rootViewController: homeViewController)
        moreViewController.router = self
        //navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(moreViewController, animated: false)
    }
    
    func showAttendance(){
        guard
          let attendanceViewController = UIStoryboard.storyboard(.attend).instantiateViewController(AttendanceViewController.self) else {
            return
        }
        //        let homeNavigationController = BaseNavigationController.init(rootViewController: homeViewController)
        attendanceViewController.router = self
        //navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(attendanceViewController, animated: false)
    }
}
