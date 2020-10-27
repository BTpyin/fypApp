//
//  LoginViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 15/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import FirebaseAuth

class LoginViewController: BaseViewController, UITextFieldDelegate {

    var viewModel: LoginInViewModel?
    var disposeBag = DisposeBag()

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var sidTextField: UITextField!
    @IBOutlet weak var loginBackgroundView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginBottomLineView: UIView!
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginInViewModel()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.navigationItem.title = "Login"
        configureUI()
        
        sidTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {_ in
                self.viewModel?.sidInput.value = self.sidTextField.text
                self.viewModel?.enableCheck()
            })
            .disposed(by: disposeBag)
        
        
        emailTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {_ in
                self.viewModel?.emailInput.value = self.emailTextField.text
                self.viewModel?.enableCheck()
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {_ in
                self.viewModel?.passwordInput.value = self.passwordTextField.text
                self.viewModel?.enableCheck()
            })
            .disposed(by: disposeBag)
        
        viewModel?.loginEnable.asObservable().subscribe(onNext: { (_) in
            self.loginButton.isEnabled = (self.viewModel?.loginEnable.value)!
            if (!(self.loginButton.isEnabled)){
//                self.signInButton.titleLabel?.textColor = UIColor.init(red: 128, green: 128, blue: 128)
                self.loginBackgroundView.backgroundColor = UIColor.init(red: 196/255, green: 196/255, blue: 196/255, alpha: 0.2)
                self.loginBottomLineView.backgroundColor = UIColor.init(red: 128, green: 128, blue: 128)
            }else{

//                self.signInButton.titleLabel?.textColor = UIColor.init(red: 255, green: 189, blue: 43)
                self.loginBottomLineView.backgroundColor = UIColor.systemOrange
                self.loginBackgroundView.backgroundColor = UIColor.init(red: 255/255, green: 189/255, blue: 43/255, alpha: 0.1)
            }
          }).disposed(by: disposeBag)
        
    }
    
    func configureUI(){
        sidTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        sidTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)
        emailTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        emailTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)
        passwordTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        passwordTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)

        self.loginButton.setTitleColor(UIColor.init(red: 255, green: 189, blue: 43), for: .normal)
        self.loginButton.setTitleColor(UIColor.init(red: 128, green: 128, blue: 128), for: .disabled)
        self.loginBottomLineView.backgroundColor = UIColor.init(red: 128, green: 128, blue: 128)
    }

    

    @IBAction func loginClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: (viewModel?.emailInput.value)!, password: (viewModel?.passwordInput.value)!) { (user, error) in
            if error == nil {
//                UserDefaults.standard.set(true, forKey: "loggedIn")
                UserDefaults.standard.set(self.viewModel?.sidInput.value, forKey: "studentId")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initial = storyboard.instantiateInitialViewController()
                UIApplication.shared.keyWindow?.rootViewController = initial
            }
            else {
//                 let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
//                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//
//                  alertController.addAction(defaultAction)
//                  self.present(alertController, animated: true, completion: nil)
                self.showAlert(error?.localizedDescription)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case sidTextField : emailTextField.becomeFirstResponder()
            break
        case emailTextField : passwordTextField.becomeFirstResponder()
        case passwordTextField: passwordTextField.resignFirstResponder()

        default:
            break
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

class LoginInViewModel{
    var sidInput = Variable<String?>(nil)
    var emailInput = Variable<String?>(nil)
    var passwordInput = Variable<String?>(nil)
    var loginEnable = Variable<Bool>(false)
    
    func enableCheck(){
        if(sidInput.value != "" && sidInput.value?.count == 8 && emailInput.value != "" && passwordInput.value != ""){
            loginEnable.value = true
        }
        else{
            loginEnable.value = false
        }
    }
    
}
