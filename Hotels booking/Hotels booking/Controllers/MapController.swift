//
//  MapController.swift
//  Hotels booking
//
//  Created by Viktor on 5/14/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapController: UIViewController {

    @IBOutlet weak var confirmBt: UIButton!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var mapMC: MKMapView!
    let hotel = NSManagedObject()
    var cityAnnotation = MKPointAnnotation()
    var login = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavigationBar()
        makeStyle()
        addHotelAnnotation()
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
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "RouteVC") as! RouteController
        firstVC.destinationCity = hotel.value(forKey: "city") as! String
        firstVC.originCity = cityAnnotation.title!
        firstVC.hotel = hotel
        firstVC.login = login
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    
    //MARK: - map functional
    
    func addHotelAnnotation(){
        let hotelAnnotation = MKPointAnnotation()
        CLGeocoder().geocodeAddressString(hotel.value(forKey: "city") as! String, completionHandler: {(placemarks,error)->Void  in
            if(error != nil){
                print("Geocoder failed with error "+error!.localizedDescription)
                return
            }
            if(placemarks!.count>0){
                let pm = placemarks![0]
                hotelAnnotation.coordinate = pm.location!.coordinate
            }
            })
        hotelAnnotation.title = (hotel.value(forKey: "name") as! String)
        mapMC.addAnnotation(hotelAnnotation)
    }

    @IBAction func mapTapped(_ sender: Any) {
        let touchLocation = (sender as! UITapGestureRecognizer).location(in: mapMC)
        let tapCoordinate = mapMC.convert(touchLocation, toCoordinateFrom: mapMC)
        var cityFromName:String = ""
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: tapCoordinate.latitude, longitude: tapCoordinate.longitude), completionHandler: {(placemarks,error)->Void  in
        if(error != nil){
            print("Geocoder failed with error "+error!.localizedDescription)
            return
        }
        if(placemarks!.count>0){
            let pm = placemarks![0]
            cityFromName = pm.name ?? ""
        }
        })
        fromTF.text = cityFromName
        if(mapMC.annotations.count>1){
            mapMC.removeAnnotation(cityAnnotation)
        }
        cityAnnotation.coordinate = tapCoordinate
        cityAnnotation.title = cityFromName
        mapMC.addAnnotation(cityAnnotation)
    }
    
}
