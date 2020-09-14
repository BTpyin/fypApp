//
//  BaseViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 14/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var clearColorNavigationBar: Bool = false
    var hideNavigationBarShadow: Bool = false
    
    // Store a navBar reference for un-doing navBar style change after navigationController == nil
    weak var modifiedNavigationBar: UINavigationBar?
    
    var router: Router?
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if hideNavigationBarShadow {
//            navigationController?.navigationBar.shadowImage = UIImage()
//        }
//        if clearColorNavigationBar {
//            changeNavigationBarToClearColor(true)
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if hideNavigationBarShadow {
//            navigationController?.navigationBar.shadowImage = nil
//        }
//        if clearColorNavigationBar {
//            changeNavigationBarToClearColor(false)
//        }
//    }
    

    func startLoading() {
      loadingIndicator?.startAnimating()
      loadingIndicator?.isHidden = false
    }

    func stopLoading() {
      loadingIndicator?.isHidden = true
    }

    func isLoading() -> Bool {
      return !(loadingIndicator?.isHidden ?? true)
    }
    
//    func showErrorAlert(reason: SyncDataFailReason? = nil,
//                          showCache: Bool = false,
//                          okClicked: ((UIAlertAction) -> Void)? = nil) {
//        if reason == .network {
//          if showCache {
//            showAlert("Network Error",
//                      okClicked: okClicked)
//          } else {
//            showAlert("network Error",
//                      okClicked: okClicked)
//          }
//        } else if reason == .other ||
//          reason == .realmWrite ||
//          reason == nil {
//          showAlert("Error",
//                    okClicked: okClicked)
//        }
//      }
    
    func showAlert(_ title: String?, okClicked: ((UIAlertAction) -> Void)? = nil) {
      let alertVC = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction.init(title: "OK", style: .default, handler: okClicked))
      present(alertVC, animated: true, completion: nil)
    }
    
    
//    func changeNavigationBarToClearColor(_ clear: Bool) {
//        guard let navigationBar = navigationController?.navigationBar ?? modifiedNavigationBar else {
//            print("\(self) Navgiation Bar not found")
//            return
//        }
//
//        if clear {
//            navigationBar.setBackgroundImage(UIImage(), for: .default)
//            navigationBar.shadowImage = UIImage()
//            navigationBar.isTranslucent = true
//            navigationBar.tintColor = UIColor.white
//
//            modifiedNavigationBar = navigationBar
//
//            if #available(iOS 13.0, *) {
//                let navigationBarAppearance = UINavigationBarAppearance()
//                navigationBarAppearance.configureWithTransparentBackground()
//                navigationBarAppearance.backgroundColor = .clear
//                //        navigationBarAppearance.backgroundImage = image
//                navigationBarAppearance.shadowColor = nil
//                navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//
//                navigationBar.scrollEdgeAppearance = navigationBarAppearance
//                navigationBar.compactAppearance = navigationBarAppearance
//                navigationBar.standardAppearance = navigationBarAppearance
//            }
//
//        } else {
//            RootRouter.updateNavigationBarStyle(navBar: navigationBar)
//            navigationBar.shadowImage = nil
//            navigationBar.isTranslucent = false
//
//            modifiedNavigationBar = nil
//        }
//    }
    
}
