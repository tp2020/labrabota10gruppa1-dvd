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
    
    var hotel: NSManagedObject?
    var cityAnnotation = MKPointAnnotation()
    var login = ""
    var typeOfRoom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavigationBar()
        makeStyle()
        addHotelAnnotation()
        toTF.text = hotel!.value(forKey: "name") as? String
    }
    
    func makeStyle(){
        //confirmBt.backgroundColor = .clear
        //confirmBt.layer.cornerRadius = 2
        confirmBt.layer.borderWidth = 1
        confirmBt.layer.borderColor = UIColor.black.cgColor
        
        styleTextField(tf: fromTF)
        styleTextField(tf: toTF)
    }
    
    func styleTextField(tf: UITextField){
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: tf.frame.height - 2, width: tf.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        
        tf.borderStyle = .none
        
        tf.layer.addSublayer(bottomLine)
    }
    
    @IBAction func fromTFUpdated(_ sender: Any) {
        if (fromTF.text != "") {
            confirmBt.isEnabled = true
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if (fromTF.text != "") {
            let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "RouteVC") as! RouteController
            firstVC.destinationCity = hotel!.value(forKey: "city") as! String
            firstVC.originCity = fromTF.text!
            firstVC.hotel = hotel!
            firstVC.login = login
            firstVC.typeOfRoom = typeOfRoom
            self.navigationController?.pushViewController(firstVC, animated: true)
        }
    }
    
    //MARK: - map functional
    
    func addHotelAnnotation() {
        let hotelAnnotation = MKPointAnnotation()
        CLGeocoder().geocodeAddressString(hotel!.value(forKey: "city") as! String,
                                          completionHandler: {(placemarks, error) in
                                                              if (error != nil) {
                                                                  print("Geocoder failed with error "+error!.localizedDescription)
                                                                  return
                                                              }
                                                              if (placemarks!.count > 0) {
                                                                  let placemark = placemarks![0]
                                                                  hotelAnnotation.coordinate = placemark.location!.coordinate
                                                              }})
        hotelAnnotation.title = (hotel!.value(forKey: "name") as! String)
        mapMC.addAnnotation(hotelAnnotation)
    }

    @IBAction func mapTapped(_ sender: Any) {
        let touchLocation = (sender as! UITapGestureRecognizer).location(in: mapMC)
        let tapCoordinate = mapMC.convert(touchLocation, toCoordinateFrom: mapMC)
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: tapCoordinate.latitude, longitude: tapCoordinate.longitude),
                                            completionHandler: {(placemarks, error)  in
                                                                if (error != nil) {
                                                                    print("Geocoder failed with error "+error!.localizedDescription)
                                                                    return
                                                                }
                                                                if (placemarks!.count > 0) {
                                                                    let placemark = placemarks![0]
                                                                    self.fromTF.text = placemark.locality
                                                                    if (self.mapMC.annotations.count > 1) {
                                                                        self.mapMC.removeAnnotation(self.cityAnnotation)
                                                                    }
                                                                    self.cityAnnotation.coordinate = tapCoordinate
                                                                    self.cityAnnotation.title = self.fromTF.text
                                                                    self.mapMC.addAnnotation(self.cityAnnotation)
                                                                    if(self.cityAnnotation.title != ""){
                                                                        self.confirmBt.isEnabled = true
                                                                    }
                                                                }})
    }
}
