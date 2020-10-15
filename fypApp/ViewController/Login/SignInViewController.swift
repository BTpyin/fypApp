//
//  SignInViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var signInButton: UIButton!
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
