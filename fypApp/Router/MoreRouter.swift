//
//  MoreRouter.swift
//  fypApp
//
//  Created by Bowie Tso on 24/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//
import UIKit

class MoreRouter: Router{
    
    func showProfile(){
        guard
            let profileViewController = UIStoryboard.storyboard(.more).instantiateViewController(ProfileViewController.self) else {
              return
          }
          
        profileViewController.router = self
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
