//
//  DataLoader.swift
//  Hotels booking
//
//  Created by Admin on 15.05.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataOperator {
    private static var instance: DataOperator?
    private var managedContext: NSManagedObjectContext
    
    private func addHotel(name: String, descriptions: String, country: String, city: String, numbOfLuxRooms: Int, numbOfStRooms: Int, luxPrice: Int, standardPrice:Int) {
        let entity = NSEntityDescription.entity(forEntityName: "Hotel", in: managedContext)!

        let hotel = NSManagedObject(entity: entity, insertInto: managedContext)
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
    
    private func addRoute(transportType: String, cityFrom: String, cityTo: String, price: Int, time: String, timeOfArrive: String, numbOfTickets: Int, company: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Route", in: managedContext)!
        let route = NSManagedObject(entity: entity, insertInto: managedContext)
        
        route.setValue(cityFrom, forKey: "cityFrom")
        route.setValue(cityTo, forKey: "cityTo")
        route.setValue(time, forKey: "time")
        route.setValue(timeOfArrive, forKey: "timeOfArrive")
        route.setValue(company, forKey: "company")
        route.setValue(price, forKey: "Price")
        route.setValue(numbOfTickets, forKey: "numbOfTickets")
        
        let entityTransport = NSEntityDescription.entity(forEntityName: "Transport", in: managedContext)!
        let transport = NSManagedObject(entity: entityTransport, insertInto: managedContext)
        transport.setValue(transportType, forKey: "type")
        route.setValue(transport, forKey: "transport")
        
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can't load AppDelegate!")
        }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    static func getInstance() -> DataOperator {
        if (instance == nil) {
            instance = DataOperator()
        }
        return instance!
    }
    
    func deleteAllData(forEntity entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for object in result {
                guard let objectData = object as? NSManagedObject
                else {
                    continue
                }
                managedContext.delete(objectData)
                try managedContext.save()
            }
        }
        catch let error as NSError {
            fatalError(error.description)
        }
    }
    
    func fillDatabase() {
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
        addHotel(name: "Hotel Florida",descriptions: "Charming hotel in the capital of the country",country: "Ukraine",city: "Kyiv", numbOfLuxRooms: 6,numbOfStRooms: 32,luxPrice: 780,standardPrice: 410);

        addRoute(transportType: "Bus", cityFrom: "Warsaw", cityTo: "Valencia", price: 76, time: "2020-05-17 17:28", timeOfArrive: "2020-05-20 13:35", numbOfTickets: 100, company: "Minoblautotrans")
        addRoute(transportType: "Plane", cityFrom: "Warsaw", cityTo: "Venice", price: 16, time: "2020-05-12 11:30", timeOfArrive: "2020-05-12 13:23", numbOfTickets: 99, company: "Belavia")
        addRoute(transportType: "Bus", cityFrom: "Warsaw", cityTo: "Madrid", price: 67, time: "2020-05-14 15:27", timeOfArrive: "2020-05-17 16:45", numbOfTickets: 95, company: "Ecolines")
        addRoute(transportType: "Train", cityFrom: "Warsaw", cityTo: "Naples", price: 123, time: "2020-05-18 14:16", timeOfArrive: "2020-05-21 13:54", numbOfTickets: 72, company: "PKP")
        addRoute(transportType: "Train", cityFrom: "Tallinn", cityTo: "Anapa", price: 119, time: "2020-05-13 16:20", timeOfArrive: "2020-05-15 09:01", numbOfTickets: 46, company: "Eesti Raudtee")
        addRoute(transportType: "Bus", cityFrom: "Minsk", cityTo: "Herceg Novi", price: 93, time: "2020-05-14 15:23", timeOfArrive: "2020-05-16 03:00", numbOfTickets: 43, company: "Ivan Susanin LLC")
        addRoute(transportType: "Bus", cityFrom: "Vilnius", cityTo: "Herceg Novi", price: 86, time: "2020-05-17 12:22", timeOfArrive: "2020-05-19 06:15", numbOfTickets: 31, company: "Minoblautotrans")
        addRoute(transportType: "Train", cityFrom: "Minsk", cityTo: "Sochi", price: 147, time: "2020-05-12 14:20", timeOfArrive: "2020-05-14 13:41", numbOfTickets: 71, company: "BelZhD")
        addRoute(transportType: "Plane", cityFrom: "Vilnius", cityTo: "Antalya", price: 141, time: "2020-05-17 17:16", timeOfArrive: "2020-05-17 18:41", numbOfTickets: 43, company: "Belavia")
        addRoute(transportType: "Plane", cityFrom: "Vilnius", cityTo: "Istanbul", price: 59, time: "2020-05-17 17:34", timeOfArrive: "2020-05-17 19:45", numbOfTickets: 11, company: "Lufthansa")
        addRoute(transportType: "Train", cityFrom: "Riga", cityTo: "Odesa", price: 66, time: "2020-05-12 17:33", timeOfArrive: "2020-05-14 01:15", numbOfTickets: 44, company: "Latvian Railways")
        addRoute(transportType: "Plane", cityFrom: "Tallinn", cityTo: "Kyiv", price: 53, time: "2020-05-18 08:19", timeOfArrive: "2020-05-18 08:55", numbOfTickets: 82, company: "Ryanair")
        addRoute(transportType: "Train", cityFrom: "Minsk", cityTo: "Venice", price: 42, time: "2020-05-12 12:17", timeOfArrive: "2020-05-14 13:33", numbOfTickets: 32, company: "BelZhD")
        addRoute(transportType: "Plane", cityFrom: "Warsaw", cityTo: "Izmir", price: 88, time: "2020-05-14 11:24", timeOfArrive: "2020-05-14 13:24", numbOfTickets: 52, company: "Aeroflot")
        addRoute(transportType: "Plane", cityFrom: "Vilnius", cityTo: "Valencia", price: 122, time: "2020-05-13 16:30", timeOfArrive: "2020-05-13 19:45", numbOfTickets: 37, company: "Wizzair")
        addRoute(transportType: "Train", cityFrom: "Moscow", cityTo: "Valencia", price: 102, time: "2020-05-13 14:25", timeOfArrive: "2020-05-17 05:01", numbOfTickets: 19, company: "RZhD")
        addRoute(transportType: "Train", cityFrom: "Riga", cityTo: "Venice", price: 56, time: "2020-05-15 12:31", timeOfArrive: "2020-05-17 13:01", numbOfTickets: 15, company: "Latvian Railways")
        addRoute(transportType: "Plane", cityFrom: "Riga", cityTo: "Kyiv", price: 33, time: "2020-05-12 10:26", timeOfArrive: "2020-05-12 10:59", numbOfTickets: 63, company: "Belavia")
        addRoute(transportType: "Train", cityFrom: "Vilnius", cityTo: "Antalya", price: 83, time: "2020-05-16 10:30", timeOfArrive: "2020-05-18 16:24", numbOfTickets: 40, company: "Lithuanian Railways")
        addRoute(transportType: "Plane", cityFrom: "Vilnius", cityTo: "Venice", price: 35, time: "2020-05-16 12:32", timeOfArrive: "2020-05-16 14:42", numbOfTickets: 22, company: "Belavia")
        addRoute(transportType: "Plane", cityFrom: "Minsk", cityTo: "Moscow", price: 29, time: "2020-05-14 10:19", timeOfArrive: "2020-05-14 11:08", numbOfTickets: 43, company: "Aeroflot")
        addRoute(transportType: "Bus", cityFrom: "Moscow", cityTo: "Sochi", price: 126, time: "2020-05-14 11:34", timeOfArrive: "2020-05-15 22:37", numbOfTickets: 28, company: "Ivan Susanin LLC")
        addRoute(transportType: "Bus", cityFrom: "Minsk", cityTo: "Anapa", price: 62, time: "2020-05-17 17:20", timeOfArrive: "2020-05-19 00:10", numbOfTickets: 48, company: "Minoblautotrans")
        addRoute(transportType: "Train", cityFrom: "Minsk", cityTo: "Thessaloniki", price: 100, time: "2020-05-18 12:34", timeOfArrive: "2020-05-20 22:31", numbOfTickets: 24, company: "BelZhD")
        addRoute(transportType: "Plane", cityFrom: "Vilnius", cityTo: "Podgorica", price: 47, time: "2020-05-13 08:22", timeOfArrive: "2020-05-13 10:10", numbOfTickets: 94, company: "Lufthansa")
        addRoute(transportType: "Bus", cityFrom: "Minsk", cityTo: "Thessaloniki", price: 48, time: "2020-05-17 08:35", timeOfArrive: "2020-05-19 01:51", numbOfTickets: 18, company: "Ecolines")
        addRoute(transportType: "Plane", cityFrom: "Kyiv", cityTo: "Sochi", price: 125, time: "2020-05-17 15:16", timeOfArrive: "2020-05-17 16:39", numbOfTickets: 36, company: "Ryanair")
        addRoute(transportType: "Plane", cityFrom: "Tallinn", cityTo: "Valencia", price: 31, time: "2020-05-18 10:23", timeOfArrive: "2020-05-18 13:49", numbOfTickets: 56, company: "Wizzair")
        addRoute(transportType: "Train", cityFrom: "Vilnius", cityTo: "Sochi", price: 140, time: "2020-05-12 15:25", timeOfArrive: "2020-05-14 10:49", numbOfTickets: 86, company: "Lithuanian Railways")
        addRoute(transportType: "Bus", cityFrom: "Vilnius", cityTo: "Kyiv", price: 50, time: "2020-05-12 17:20", timeOfArrive: "2020-05-13 01:58", numbOfTickets: 63, company: "Minoblautotrans")
        addRoute(transportType: "Plane", cityFrom: "Kyiv", cityTo: "Sochi", price: 115, time: "2020-05-18 16:24", timeOfArrive: "2020-05-18 17:58", numbOfTickets: 49, company: "Belavia")
        addRoute(transportType: "Plane", cityFrom: "Kyiv", cityTo: "Podgorica", price: 103, time: "2020-05-14 16:28", timeOfArrive: "2020-05-14 18:30", numbOfTickets: 37, company: "Wizzair")
        addRoute(transportType: "Plane", cityFrom: "Warsaw", cityTo: "Naples", price: 32, time: "2020-05-16 10:24", timeOfArrive: "2020-05-16 12:13", numbOfTickets: 17, company: "Aeroflot")
        addRoute(transportType: "Plane", cityFrom: "Tallinn", cityTo: "Ulcinj", price: 18, time: "2020-05-16 11:24", timeOfArrive: "2020-05-16 13:41", numbOfTickets: 18, company: "Ryanair")
        addRoute(transportType: "Plane", cityFrom: "Riga", cityTo: "Odesa", price: 20, time: "2020-05-13 08:20", timeOfArrive: "2020-05-13 09:05", numbOfTickets: 64, company: "Turkish Airlines")
        addRoute(transportType: "Train", cityFrom: "Riga", cityTo: "Herceg Novi", price: 21, time: "2020-05-17 08:29", timeOfArrive: "2020-05-19 06:00", numbOfTickets: 13, company: "Latvian Railways")
        addRoute(transportType: "Plane", cityFrom: "Minsk", cityTo: "Sochi", price: 100, time: "2020-05-16 14:28", timeOfArrive: "2020-05-16 15:38", numbOfTickets: 31, company: "Lufthansa")
        addRoute(transportType: "Plane", cityFrom: "Warsaw", cityTo: "Kyiv", price: 56, time: "2020-05-18 07:18", timeOfArrive: "2020-05-18 07:48", numbOfTickets: 86, company: "Wizzair")
        addRoute(transportType: "Train", cityFrom: "Tallinn", cityTo: "Moscow", price: 59, time: "2020-05-16 14:35", timeOfArrive: "2020-05-17 13:09", numbOfTickets: 71, company: "Eesti Raudtee")
        addRoute(transportType: "Plane", cityFrom: "Kyiv", cityTo: "Madrid", price: 76, time: "2020-05-15 15:31", timeOfArrive: "2020-05-15 18:25", numbOfTickets: 71, company: "Lufthansa")
        addRoute(transportType: "Train", cityFrom: "Tallinn", cityTo: "Sochi", price: 15, time: "2020-05-15 10:28", timeOfArrive: "2020-05-17 03:07", numbOfTickets: 43, company: "Eesti Raudtee")
        addRoute(transportType: "Bus", cityFrom: "Vilnius", cityTo: "Venice", price: 149, time: "2020-05-18 17:28", timeOfArrive: "2020-05-20 03:20", numbOfTickets: 85, company: "Ecolines")
        addRoute(transportType: "Plane", cityFrom: "Kyiv", cityTo: "Herceg Novi", price: 101, time: "2020-05-15 17:20", timeOfArrive: "2020-05-15 19:24", numbOfTickets: 66, company: "Turkish Airlines")
        addRoute(transportType: "Train", cityFrom: "Tallinn", cityTo: "Madrid", price: 75, time: "2020-05-12 15:35", timeOfArrive: "2020-05-16 20:10", numbOfTickets: 27, company: "Eesti Raudtee")
        addRoute(transportType: "Bus", cityFrom: "Tallinn", cityTo: "Valencia", price: 39, time: "2020-05-16 11:35", timeOfArrive: "2020-05-19 00:13", numbOfTickets: 74, company: "Ivan Susanin LLC")
        addRoute(transportType: "Bus", cityFrom: "Moscow", cityTo: "Venice", price: 115, time: "2020-05-17 10:17", timeOfArrive: "2020-05-18 17:10", numbOfTickets: 96, company: "Minoblautotrans")
        addRoute(transportType: "Bus", cityFrom: "Riga", cityTo: "Izmir", price: 111, time: "2020-05-15 14:17", timeOfArrive: "2020-05-17 09:48", numbOfTickets: 60, company: "Minoblautotrans")
        addRoute(transportType: "Bus", cityFrom: "Minsk", cityTo: "Naples", price: 96, time: "2020-05-12 13:35", timeOfArrive: "2020-05-14 03:47", numbOfTickets: 53, company: "Minoblautotrans")
        addRoute(transportType: "Bus", cityFrom: "Vilnius", cityTo: "Naples", price: 127, time: "2020-05-16 13:17", timeOfArrive: "2020-05-18 08:22", numbOfTickets: 17, company: "Ecolines")
    }
    
    func loadReservationData(forLogin login: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Reservation")
        var reservations = [NSManagedObject]()
        var fetchResult = [NSManagedObject]()
        do {
            fetchResult = try managedContext.fetch(fetchRequest)
            reservations += fetchResult.filter({(object) -> Bool in
                                                object.value(forKey: "user") as? String == login})
        }
        catch let error as NSError {
            fatalError("Could not fetch. \(error), \(error.userInfo)")
        }
        return reservations
    }
    
    func loadHotelData() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Hotel")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "city", ascending: true)]
        var hotels = [NSManagedObject]()
        var fetchResult = [NSManagedObject]()
        do {
            fetchResult = try managedContext.fetch(fetchRequest)
            hotels += fetchResult.filter({(object) -> Bool in
                                          object.value(forKey: "numbOfStRooms") as? Int != 0 ||
                                          object.value(forKey: "numbOfLuxRooms") as? Int != 0})
        }
        catch let error as NSError {
            print("Can't retrieve hotels: \(error)")
        }
        return hotels
    }
    
    func loadRouteData(originCity: String, destinationCity: String, typeOfTransport: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Route")
        var routes = [NSManagedObject]()
        var fetchResult = [NSManagedObject]()
        do {
            fetchResult = try managedContext.fetch(fetchRequest)
            routes += fetchResult
                      .filter({(object) -> Bool in
                              object.value(forKey: "cityFrom") as? String == originCity &&
                              object.value(forKey: "cityTo") as? String == destinationCity &&
                              (object.value(forKey: "transport") as! NSManagedObject).value(forKey: "type") as! String == typeOfTransport})
        }
        catch let error as NSError {
            print("Can't retrieve routes: \(error)")
        }
        return routes
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
