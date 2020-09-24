//
//  ProfileViewController.swift
//  fypApp
//
//  Created by Bowie Tso on 24/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var chiNameTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var sidTextField: UITextField!
    @IBOutlet weak var programTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    var moreRouter : MoreRouter?{
        return router as? MoreRouter
    }
    
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiBind()
        // Do any additional setup after loading the view.
    }
    
    func uiBind(){
        profileView.roundCorners(cornerRadius: 25)
        profileView.layer.applySketchShadow(
          color: .black,
          alpha: 0.4,
          x: 0,
            y: 0.5,
          blur: 6,
            spread: 0)
        updateButton.roundCorners(cornerRadius: 10)
        firstNameTextField.roundCorners(cornerRadius: 10)
        lastNameTextField.roundCorners(cornerRadius: 10)
        chiNameTextField.roundCorners(cornerRadius: 10)
        displayNameTextField.roundCorners(cornerRadius: 10)
        sidTextField.roundCorners(cornerRadius: 10)
        programTextField.roundCorners(cornerRadius: 10)
        majorTextField.roundCorners(cornerRadius: 10)
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
