//
//  MapController.swift
//  Hotels booking
//
//  Created by Viktor on 5/14/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {

    @IBOutlet weak var confirmBt: UIButton!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var mapMC: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavigationBar()
        makeStyle()
        
        // Do any additional setup after loading the view.
    }
    
    func makeStyle(){
        //confirmBt.backgroundColor = .clear
        //confirmBt.layer.cornerRadius = 2
        confirmBt.layer.borderWidth = 1
        confirmBt.layer.borderColor = UIColor.black.cgColor
        
        styleTextField(tf: fromTF)
        styleTextField(tf: toTF)
    }
    
    func styleTextField(tf : UITextField){
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: tf.frame.height - 2, width: tf.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        
        tf.borderStyle = .none
        
        tf.layer.addSublayer(bottomLine)
    }
    @IBAction func fromTFUpdated(_ sender: Any) {
        if(fromTF.text != ""){
            confirmBt.isEnabled = true
        }
        
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
    }
    


}
