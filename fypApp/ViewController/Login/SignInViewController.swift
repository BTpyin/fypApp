//
//  SignInViewController.swift
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

class SignInViewController: BaseViewController, UITextFieldDelegate {
    
    var viewModel: SignInViewModel?
    var disposeBag = DisposeBag()

    @IBOutlet weak var sidTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var buttonBackgroundView: UIView!
    
    @IBOutlet weak var buttonLine: UIView!
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sidTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        reEnterTextField.delegate = self
        viewModel = SignInViewModel()
        self.navigationItem.title = "Register"
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
        
        reEnterTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {_ in
                self.viewModel?.reInputPassword.value = self.reEnterTextField.text
                self.viewModel?.enableCheck()
            })
            .disposed(by: disposeBag)
        
        
        viewModel?.signInEnable.asObservable().subscribe(onNext: { (_) in
            self.signInButton.isEnabled = (self.viewModel?.signInEnable.value)!
            if (!(self.signInButton.isEnabled)){
//                self.signInButton.titleLabel?.textColor = UIColor.init(red: 128, green: 128, blue: 128)
                self.buttonBackgroundView.backgroundColor = UIColor.init(red: 196/255, green: 196/255, blue: 196/255, alpha: 0.2)
                self.buttonLine.backgroundColor = UIColor.init(red: 128, green: 128, blue: 128)
            }else{

//                self.signInButton.titleLabel?.textColor = UIColor.init(red: 255, green: 189, blue: 43)
                self.buttonLine.backgroundColor = UIColor.systemOrange
                self.buttonBackgroundView.backgroundColor = UIColor.init(red: 255/255, green: 189/255, blue: 43/255, alpha: 0.1)
            }
          }).disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }
    
    func configureUI(){
        sidTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        sidTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)
        emailTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        emailTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)
        passwordTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        passwordTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)
        reEnterTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        reEnterTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)
        self.signInButton.setTitleColor(UIColor.init(red: 255, green: 189, blue: 43), for: .normal)
        self.signInButton.setTitleColor(UIColor.init(red: 128, green: 128, blue: 128), for: .disabled)
        self.buttonLine.backgroundColor = UIColor.init(red: 128, green: 128, blue: 128)
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
//    @IBAction func sidChanged(_ sender: Any) {
//        viewModel?.sidInput.value = sidTextField.text
//        viewModel?.enableCheck()
//    }
//    @IBAction func emailChanged(_ sender: Any) {
//        viewModel?.emailInput.value = emailTextField.text
//        viewModel?.enableCheck()
//    }
//    @IBAction func reEnterChanged(_ sender: Any) {
//        viewModel?.reInputPassword.value = reEnterTextField.text
//        viewModel?.enableCheck()
//    }
//    @IBAction func passwordChanged(_ sender: Any) {
//        viewModel?.passwordInput.value = passwordTextField.text
//        viewModel?.enableCheck()
//    }
    
    @IBAction func signInClicked(_ sender: Any) {

        if(passwordTextField.text != reEnterTextField.text){
            showAlert("Please Re-Enter Password!")
        }
        
        viewModel?.sidInput.value = sidTextField.text
        viewModel?.emailInput.value = emailTextField.text
        
        Api().checkSidValid(sid: (viewModel?.sidInput.value)!, success: {(response) in
            guard let valid = response else{
                self.showAlert("Fail to Register your Account")
                return
            }
            
            if (valid.valid){

                Auth.auth().createUser(withEmail: (self.viewModel?.emailInput.value)!, password: (self.viewModel?.passwordInput.value)!){ (user, error) in
                    if error == nil {
                        self.navigationController?.popViewController(animated: true)
                    }
                    else{
//                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
//                   let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//
//                    alertController.addAction(defaultAction)
//                    self.present(alertController, animated: true, completion: nil)
                        self.showAlert(error?.localizedDescription)
                        
                    }
                    
                }
                
            }
            else{
                self.showAlert("Your Account had been Registered")
            }
            
        }, fail: { (error, resposne) in
            print("Reqeust Error: \(String(describing: error))")
//            let reason = self.failReason(error: error, resposne: resposne)
            self.showAlert("Fail to Register your Account")
        })
//        navigationController?.popViewController(animated: true)
    }


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

class SignInViewModel{
    var sidInput = Variable<String?>(nil)
    var passwordInput = Variable<String?>(nil)
    var reInputPassword = Variable<String?>(nil)
    var emailInput = Variable<String?>(nil)
    var signInEnable = Variable<Bool>(false)
    
    func enableCheck(){
        if(sidInput.value != "" && sidInput.value?.count == 8 && passwordInput.value != "" && reInputPassword.value != "" && emailInput.value != ""){
            signInEnable.value = true
        }
        else{
            signInEnable.value = false
        }
    }
    
}
