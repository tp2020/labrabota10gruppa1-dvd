//
//  RegistrationController.swift
//  Hotels booking
//
//  Created by Viktor on 5/10/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import CoreData

/*
    RegistrationController
    Controller of registration scene
 */

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
        
        if(DataOperator.getInstance().readFromPlist(key: "wasOpened") == ""){
            let dataOperator = DataOperator.getInstance()
            dataOperator.deleteAllData(forEntity: "Reservation")
            dataOperator.deleteAllData(forEntity: "Hotel")
            dataOperator.deleteAllData(forEntity: "Route")
            dataOperator.fillDatabase()
            dataOperator.writeToPlist(data: "true", key: "wasOpened")
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginController
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        if (passwordTF.text == passwordRepeatTF.text) {
            UserDefaultHelper.saveStringValue(key: emailTF.text!, value: passwordTF.text!)
            NSLog("registrated successfully" as String)
            DataOperator.getInstance().writeToPlist(data: emailTF.text!, key: "login")
            let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainController
            self.navigationController?.pushViewController(firstVC, animated: true)
        }
        else {
            Animations.shake(view: passwordRepeatTF)
            Animations.shake(view: passwordTF)
        }
    }
}
