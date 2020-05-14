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

    func fill_database(){
        addHotel(name: "Grand",descriptions: "Luxury hotel near summary beaches of mediterranean",country: "Greece",city: "Thessaloniki",numbOfLuxRooms: 10,numbOfStRooms: 50,luxPrice: 1000,standardPrice: 300);
        addHotel(name: "Catalonia Barcelona Plaza",descriptions: "Wonderful places of Spain",country: "Spain",city: "Barcelona",numbOfLuxRooms: 15,numbOfStRooms: 100,luxPrice: 1120,standardPrice: 450);
        addHotel(name: "Hostal Art Madrid",descriptions: "Cosy hotel for business trips",country: "Spain",city: "Madrid",numbOfLuxRooms: 0, numbOfStRooms: 50,luxPrice: 0,standardPrice: 350);
        addHotel(name: "Hostal ruzafa fun",descriptions: "Comfortable hostel for tourists",country: "Spain",city: "Valencia",numbOfLuxRooms: 5,numbOfStRooms: 30,luxPrice: 800,standardPrice: 375);
        addHotel(name: "Hotel Noemi",descriptions: "Great hotel with great views",country: "Italy",city: "Venice",numbOfLuxRooms: 10,numbOfStRooms: 60,luxPrice: 1220,standardPrice: 550);
        addHotel(name: "Hotel Colombo",descriptions: "Charming hotel in the center",country: "Italy",city: "Naples",numbOfLuxRooms: 0,numbOfStRooms: 25,luxPrice: 0,standardPrice: 400);
        addHotel(name: "Guesthouse Liamra",descriptions: "Small homely hotel",country: "Montenegro",city: "Ulcinj",numbOfLuxRooms: 0,numbOfStRooms: 40,luxPrice: 0,standardPrice: 420);
        addHotel(name: "Apartment city life",descriptions: "Grand hotel in the capital",country: "Montenegro",city: "Podgorica",numbOfLuxRooms: 25,numbOfStRooms: 120,luxPrice: 940,standardPrice: 350);
        addHotel(name: "Hotel azzuro",descriptions: "Beautiful view directly on the sea",country: "Montenegro",city: "Herceg Novi",numbOfLuxRooms: 12,numbOfStRooms: 50,luxPrice: 1400,standardPrice: 450);
        addHotel(name: "Lemon hotel",descriptions: "Wonderful hotel with swimming pool",country: "Turkey",city: "Antalya",numbOfLuxRooms: 20,numbOfStRooms: 120,luxPrice: 1100,standardPrice: 420);
        addHotel(name: "The New Hotel Zeybek",descriptions: "Nice hotel with restaurant",country: "Turkey",city: "Izmir",numbOfLuxRooms: 30,numbOfStRooms: 40,luxPrice: 850,standardPrice: 270);
        addHotel(name: "Seher hotel",descriptions: "Modern hotel with cozy rooms",country: "Turkey",city: "Istanbul",numbOfLuxRooms: 10,numbOfStRooms: 40,luxPrice: 890,standardPrice: 350);
        addHotel(name: "Wind Rose Hotel & SPA",descriptions: "Luxury modern hotel",country: "Russia",city: "Sochi",numbOfLuxRooms: 35,numbOfStRooms: 120,luxPrice: 1400,standardPrice: 560);
        addHotel(name: "Moskovskiy",descriptions: "Affordable hostel for tourists",country: "Russia",city: "Kaliningrad",numbOfLuxRooms: 0,numbOfStRooms: 40,luxPrice: 0,standardPrice: 240);
        addHotel(name: "Hotel Flamingo",descriptions: "Hotel with swimming pool and part of the beach",country: "Russia",city: "Anapa",numbOfLuxRooms: 4,numbOfStRooms: 12,luxPrice: 1350,standardPrice: 440);
        addHotel(name: "Royal hotel",descriptions: "Homely hoteml with restaurant",country: "Russia",city: "Moscow",numbOfLuxRooms: 5,numbOfStRooms: 130,luxPrice: 850,standardPrice: 250);
        addHotel(name: "Sova",descriptions: "Beautiful small hotel",country: "Ukraine",city: "Odesa",numbOfLuxRooms: 8,numbOfStRooms: 40,luxPrice: 750,standardPrice: 340);
        addHotel(name: "Hotel Florida",descriptions: "Charming hotel in the capital of the country",country: "Ukraine",city: "Kiev",numbOfLuxRooms: 6,numbOfStRooms: 32,luxPrice: 780,standardPrice: 410);
        
        
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
        hotel.setValue(country, forKeyPath: "country")
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
    
    func addReservation(hotel:NSManagedObject,route:NSManagedObject,typeOfRoom:String, userLogin:String){
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

        var totalPrice:Int = 0
        if(typeOfRoom == "lux"){
            totalPrice = hotel.value(forKey: "luxPrice") as! Int
        }
        else{
            totalPrice = hotel.value(forKey: "standardPrice") as! Int
        }
        totalPrice = totalPrice + (route.value(forKey: "price") as! Int)
        reservation.setValue(totalPrice,forKey: "totalPrice")
        reservation.setValue(typeOfRoom, forKey: "typeOfRoom")
        reservation.mutableSetValue(forKey: "hotel").add(hotel)
        reservation.mutableSetValue(forKey: "route").add(route)
        let date = Date()
        let formatter = DateFormatter()
        let dateString = formatter.string(from: date)
        reservation.setValue(dateString,forKey: "time")
        reservation.setValue(userLogin,forKey: "user")
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
