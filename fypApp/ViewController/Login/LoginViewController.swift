//
//  LoginViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginClicked(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "loggedIn")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
