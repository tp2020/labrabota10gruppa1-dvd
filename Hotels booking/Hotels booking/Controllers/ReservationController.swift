//
//  ReservationController.swift
//  Hotels booking
//
//  Created by Viktor on 5/15/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import CoreData

class ReservationController: UIViewController {

    @IBOutlet weak var hotelNameLb: UILabel!
    @IBOutlet weak var countryLb: UILabel!
    @IBOutlet weak var cityLb: UILabel!
    @IBOutlet weak var roomTypeLb: UILabel!
    @IBOutlet weak var routeCompanyLb: UILabel!
    @IBOutlet weak var fromLb: UILabel!
    @IBOutlet weak var departTimeLb: UILabel!
    @IBOutlet weak var toLb: UILabel!
    @IBOutlet weak var arriveLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    @IBOutlet weak var totalPriceLb: UILabel!
    
    var reservation = NSManagedObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func updateElements(){
        let hotel = reservation.value(forKey: "hotel") as! NSSet
        let route = reservation.value(forKey: "route") as! NSSet
        hotelNameLb.text = hotel.value(forKey: "name") as? String
        countryLb.text = hotel.value(forKey: "country") as? String
        cityLb.text = hotel.value(forKey: "city") as? String
        roomTypeLb.text = reservation.value(forKey: "typeOfRoom") as? String
        routeCompanyLb.text = route.value(forKey: "company") as? String
        fromLb.text = route.value(forKey: "cityFrom") as? String
        toLb.text = route.value(forKey: "cityTo") as? String
        arriveLb.text = route.value(forKey: "timeOfArrive") as? String
        descriptionLb.text = hotel.value(forKey: "descriptions") as? String
        totalPriceLb.text = String(hotel.value(forKey: "totalPrice") as! Int)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
