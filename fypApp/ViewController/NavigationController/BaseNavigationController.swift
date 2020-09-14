//
//  BaseNavigationController.swift
//  fypApp
//
//  Created by Bowie Tso on 14/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
      var router: Router? {
        didSet {
          // Pass the router into TopViewController
          if let topVC = topViewController as? BaseViewController {
            topVC.router = router
          }
            
        }
      }

      override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = true
        
      }

      override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
      }
    }
