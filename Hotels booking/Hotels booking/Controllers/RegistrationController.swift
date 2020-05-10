//
//  RegistrationController.swift
//  Hotels booking
//
//  Created by Viktor on 5/10/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    @IBOutlet weak var imageBox: UIImageView!
    @IBOutlet weak var SignBt: UIButton!
    @IBOutlet weak var createAccountBt: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordRepeatTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationBar()
        createAccountBt.layer.cornerRadius = 14
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginController
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        if(passwordTF.text==passwordRepeatTF.text){
            UserDefaultHelper.saveStringValue(key: emailTF.text!, value: passwordTF.text!)

            NSLog("registrated successfully" as String)
        }else{
            Animations.shake(view: passwordRepeatTF);
            Animations.shake(view: passwordTF);
            
        }
    }

}
