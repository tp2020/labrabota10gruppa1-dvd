//
//  LoginController.swift
//  Hotels booking
//
//  Created by Viktor on 5/9/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import Foundation
import UIKit

/*
   LoginController
   Controller of login scene
*/

class LoginController: UIViewController {
    @IBOutlet weak var registrationBt: UIButton!
    @IBOutlet weak var signInBt: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var imageBox: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.hideNavigationBar()
        signInBt.layer.cornerRadius = 14
        imageBox.layer.cornerRadius = 25
    }

    @IBAction func signInPressed(_ sender: Any) {
        if (UserDefaultHelper.isKeyExist(key: emailTF.text!)) {
            if (UserDefaultHelper.getStringValue(key: emailTF.text!) == passwordTF.text) {
                NSLog("Hello, it's me" as String)
                let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainController
                DataOperator.getInstance().writeToPlist(data: emailTF.text!, key: "login")
                self.navigationController?.pushViewController(firstVC, animated: true)
            }
            else {
                Animations.shake(view: passwordTF)
            }
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationController
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
}

extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
