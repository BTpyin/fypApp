//
//  SignInViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var sidTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sidTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        reEnterTextField.delegate = self
        self.navigationItem.title = "Register"
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case sidTextField : emailTextField.becomeFirstResponder()
            break
        case emailTextField : passwordTextField.becomeFirstResponder()
        case passwordTextField: reEnterTextField.becomeFirstResponder()
        case reEnterTextField: reEnterTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }

    @IBAction func signInClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
