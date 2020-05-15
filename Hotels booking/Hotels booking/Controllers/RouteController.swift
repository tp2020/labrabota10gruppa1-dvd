//
//  RouteController.swift
//  Hotels booking
//
//  Created by Viktor on 5/15/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import CoreData

class RouteController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var confirmBt: UIButton!
    
    @IBOutlet weak var tableTV: UITableView!
    @IBOutlet weak var segmentedSC: UISegmentedControl!
    @IBOutlet weak var imageIV: UIImageView!
    var originCity: String = ""
    var destinationCity: String = ""
    var routes: [NSManagedObject] = []
    var hotel = NSManagedObject()
    var login = ""
    var typeOfRoom = ""
    var currentIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmBt.layer.cornerRadius = 12
        loadRouteData()
        tableTV.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func loadRouteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
                   else {
                       return
                   }
               
               let managedContext = appDelegate.persistentContainer.viewContext
               
               let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Route")
               
               var requestRoutes = [NSManagedObject]()
               
               do {
                   requestRoutes = try managedContext.fetch(fetchRequest)
                routes += requestRoutes
                    .filter({(object) -> Bool in
                             object.value(forKey: "cityFrom") as? String == originCity &&
                             object.value(forKey: "cityTo") as? String == destinationCity})
               }
               catch let error as NSError {
                   print("Can't retrieve routes: \(error)")
               }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //element amounts
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCustomCell") as! RouteTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hotels list"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if(currentIndex != -1){
            addReservation(hotel: hotel, route: routes[currentIndex], typeOfRoom: typeOfRoom, userLogin: login)
            let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainController
            self.navigationController?.pushViewController(firstVC, animated: true)
        }
    }
    
    @IBAction func segmentedChanged(_ sender: Any) {
        let index = segmentedSC.selectedSegmentIndex
        if(index == 0){
            imageIV.image = UIImage(named: "bus")
        }
        if(index == 1){
            imageIV.image = UIImage(named: "train")
        }
        if(index == 2){
            imageIV.image = UIImage(named: "plane")
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
