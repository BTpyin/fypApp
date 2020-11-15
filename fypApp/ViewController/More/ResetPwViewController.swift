//
//  ResetPwViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 16/11/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import FirebaseAuth
import Firebase

class ResetPwViewController: BaseViewController, UITextFieldDelegate {

    
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    var viewModel : ResetPwViewModel?
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var buttonBackgroundView: UIView!
    
    @IBOutlet weak var buttonLine: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        reEnterTextField.delegate = self
        viewModel = ResetPwViewModel()
        self.navigationItem.title = "Reset Password"
        configureUI()
        
        
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
        
        viewModel?.resetEnable.asObservable().subscribe(onNext: { (_) in
            self.resetButton.isEnabled = (self.viewModel?.resetEnable.value)!
            if (!(self.resetButton.isEnabled)){
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
    
        // Do any additional setup after loading the view.
    }
    


    @IBAction func resetClicked(_ sender: Any) {
        resetPw()
    }
    
    func resetPw(){
        
        var autherror = true
        Auth.auth().currentUser?.updatePassword(to: (viewModel?.passwordInput.value)!){ error in
            if error == nil {

                autherror = false
            }else {
                self.showAlert(error?.localizedDescription)
                autherror = true
            }
        }
        Auth.auth().sendPasswordReset(withEmail: (Auth.auth().currentUser?.email)!){error in
            if error == nil {

                autherror = false
            }else {
                self.showAlert(error?.localizedDescription)
                autherror = true
            }
            
        }
        if (autherror == false){
            do {
                try Auth.auth().signOut()
            }
                 catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
            }
            
            UserDefaults.standard.set("", forKey: "studentId")
//            SyncData.writeRealmAsync({ (realm) in
//                realm.delete(realm.objects(Student.self))
//                realm.delete(realm.objects(Attendance.self))
//            }, completed:{
//              })
//            try? Realm().deleteAll()

            self.navigationController?.popToRootViewController(animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initial = storyboard.instantiateInitialViewController()
                UIApplication.shared.keyWindow?.rootViewController = initial
            
        }
    }
    
    func configureUI(){

        passwordTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        passwordTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)
        reEnterTextField.textColor = UIColor.init(red: 96,green: 96,blue: 96)
        reEnterTextField.borderColor = UIColor.init(red: 168,green: 168,blue: 168)
        self.resetButton.setTitleColor(UIColor.init(red: 255, green: 189, blue: 43), for: .normal)
        self.resetButton.setTitleColor(UIColor.init(red: 128, green: 128, blue: 128), for: .disabled)
        self.buttonLine.backgroundColor = UIColor.init(red: 128, green: 128, blue: 128)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case passwordTextField: reEnterTextField.becomeFirstResponder()
        case reEnterTextField: reEnterTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

class ResetPwViewModel{
    var passwordInput = Variable<String?>(nil)
    var reInputPassword = Variable<String?>(nil)
    var resetEnable = Variable<Bool>(false)
    
    func enableCheck(){
        if(passwordInput.value != "" && reInputPassword.value != "" &&  passwordInput.value == reInputPassword.value ){
            resetEnable.value = true
        }
        else{
            resetEnable.value = false
        }
    }
    
}
