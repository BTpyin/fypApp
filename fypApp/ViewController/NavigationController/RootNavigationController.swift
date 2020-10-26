//
//  RootNavigationController.swift
//  fypApp
//
//  Created by Bowie Tso on 14/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RootNavigationController: UINavigationController {
    
var router: RootRouter?
    
    override func viewDidLoad() {
       super.viewDidLoad()
       router = RootRouter(self)
        if(Auth.auth().currentUser != nil){
            router?.showHome(animated: true)
        }else{
            router?.showStart()
        }
        // Do any additional setup after loading the view.
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
