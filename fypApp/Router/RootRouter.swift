//
//  RootRouter.swift
//  fypApp
//
//  Created by Bowie Tso on 14/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//
import UIKit

class RootRouter: Router{
    
    var moreNavigationController: UINavigationController? {
        return RootMoreNavigationController() as? UINavigationController
    }
    
    func showStart(){
        guard
          let startViewController = UIStoryboard.storyboard(.login).instantiateViewController(StartViewController.self) else {
            return
        }

        startViewController.router = self
        startViewController.modalPresentationStyle = .fullScreen
        startViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(startViewController, animated: false)
    }
    
    func showLogin(){
        guard
          let loginViewController = UIStoryboard.storyboard(.login).instantiateViewController(LoginViewController.self) else {
            return
        }

        loginViewController.router = self
//        loginViewController.hidesBottomBarWhenPushed = true
        loginViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showSignIn(){
        guard
          let signInViewController = UIStoryboard.storyboard(.login).instantiateViewController(SignInViewController.self) else {
            return
        }

        signInViewController.router = self
//        signInViewController.hidesBottomBarWhenPushed = true
        signInViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(signInViewController, animated: true)
    }
    
    func showHome(animated: Bool, complete: (() -> Void)? = nil ){
        guard
          let homeViewController = UIStoryboard.storyboard(.main).instantiateViewController(HomeViewController.self) else {
            return
        }
        //        let homeNavigationController = BaseNavigationController.init(rootViewController: homeViewController)
        homeViewController.router = self
        //navigationController?.setNavigationBarHidden(true, animated: animated)
//        homeViewController.modalPresentationStyle = .fullScreen
        homeViewController.navigationController?.navigationBar.backItem?.hidesBackButton = false
        homeViewController.hidesBottomBarWhenPushed = false
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
//        moreViewController.router = MoreRouter(moreNavigationController!)
        moreViewController.router = self
        //navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(moreViewController, animated: false)
    }
    
    func showProfile(){
        guard
            let profileViewController = UIStoryboard.storyboard(.more).instantiateViewController(ProfileViewController.self) else {
              return
          }
          
        profileViewController.router = self
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.pushViewController(profileViewController, animated: true)
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
