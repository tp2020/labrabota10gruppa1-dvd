//
//  RegistrationController.swift
//  Hotels booking
//
//  Created by Viktor on 5/10/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import CoreData

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
            
            let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainController
            self.navigationController?.pushViewController(firstVC, animated: true)
            
        }else{
            Animations.shake(view: passwordRepeatTF);
            Animations.shake(view: passwordTF);
            
        }
    }

    
    func addHotel(name:String,descriptions:String,country:String,city:String,numbOfLuxRooms:Int,numbOfStRooms:Int,luxPrice:Int,
                  standardPrice:Int){
          guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                return
              }
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let entity =
                NSEntityDescription.entity(forEntityName: "Hotel",
                                           in: managedContext)!
              let hotel = NSManagedObject(entity: entity,
                                            insertInto: managedContext)
              hotel.setValue(city, forKeyPath: "city")
              hotel.setValue(name, forKey: "name")
              hotel.setValue(descriptions,forKey: "descriptions")
        hotel.setValue(numbOfLuxRooms,forKey: "numbOfLuxRooms")
        hotel.setValue(numbOfStRooms, forKey: "numbOfStRooms")
        hotel.setValue(luxPrice, forKey: "luxPrice")
        hotel.setValue(standardPrice, forKey: "standardPrice")
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addRoute(transportType:String,cityFrom:String,cityTo:String,price:Int,time:String,timeOfArrive:String,numbOfTickets:Int){
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                return
              }
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let entity =
                NSEntityDescription.entity(forEntityName: "Route",
                                           in: managedContext)!
              let route = NSManagedObject(entity: entity,
                                            insertInto: managedContext)
        route.setValue(cityFrom,forKey: "cityFrom")
        route.setValue(cityTo,forKey: "cityTo")
        route.setValue(time,forKey: "time")
        route.setValue(timeOfArrive,forKey: "timeOfArrive")
        route.setValue(price,forKey: "Price")
        route.setValue(numbOfTickets,forKey: "numbOfTickets")
        let entityTransport =
        NSEntityDescription.entity(forEntityName: "Transport",
                                   in: managedContext)!
        let transport = NSManagedObject(entity: entityTransport,
                                      insertInto: managedContext)
        transport.setValue(transportType, forKey: "type")
        route.mutableSetValue(forKey: "transport").add(transport)
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addReservation(hotel:NSManagedObject,route:NSManagedObject,typeOfRoom:String){
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                return
              }
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let entity =
                NSEntityDescription.entity(forEntityName: "Reservation",
                                           in: managedContext)!
        let reservation = NSManagedObject(entity: entity,
        insertInto: managedContext)
        
        reservation.setValue(typeOfRoom, forKey: "typeOfRoom")
        reservation.mutableSetValue(forKey: "hotel").add(hotel)
        reservation.mutableSetValue(forKey: "route").add(route)
        let date = Date()
        let formatter = DateFormatter()
        let dateString = formatter.string(from: date)
        reservation.setValue(dateString,forKey: "time")
        
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
