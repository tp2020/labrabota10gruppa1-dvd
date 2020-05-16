//
//  RouteController.swift
//  Hotels booking
//
//  Created by Viktor on 5/15/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import CoreData

/*
   RouteController
   Controller of route selection scene
*/

class RouteController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var confirmBt: UIButton!
    @IBOutlet weak var tableTV: UITableView!
    @IBOutlet weak var segmentedSC: UISegmentedControl!
    @IBOutlet weak var imageIV: UIImageView!
    
    var originCity: String = ""
    var destinationCity: String = ""
    var routes: [NSManagedObject] = []
    var hotel: NSManagedObject?
    var login = ""
    var typeOfRoom = ""
    var typeOfTransport = "Bus"
    var currentIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmBt.layer.cornerRadius = 12
        imageIV.image = UIImage(named: "Bus")
        login = DataOperator.getInstance().readFromPlist(key: "login")
        typeOfRoom = DataOperator.getInstance().readFromPlist(key: "typeOfRoom")
        
        tableTV.delegate = self
        tableTV.dataSource = self
        routes = DataOperator.getInstance().loadRouteData(originCity: originCity, destinationCity: destinationCity, typeOfTransport: typeOfTransport)
        tableTV.reloadData()
    }
    
    //MARK: - table functional
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCustomCell") as! RouteTableViewCell
        
        let route = routes[indexPath.row]
        cell.fromLb.text = route.value(forKey: "cityFrom") as? String
        cell.toLb.text = route.value(forKey: "cityTo") as? String
        cell.priceLb.text = String(route.value(forKey: "price") as! Int)
        cell.departTimeLb.text = route.value(forKey: "time") as? String
        cell.arriveTimeLb.text = route.value(forKey: "timeOfArrive") as? String
        cell.companyLb.text = route.value(forKey: "company") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hotels list"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
    }
    
    //MARK: - interface functional
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if (currentIndex != -1) {
            DataOperator.getInstance().addReservation(hotel: hotel!, route: routes[currentIndex], typeOfRoom: typeOfRoom, userLogin: login)
            let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainController
            firstVC.login = login
            self.navigationController?.pushViewController(firstVC, animated: true)
        }
    }
    
    @IBAction func segmentedChanged(_ sender: Any) {
        let index = segmentedSC.selectedSegmentIndex
        switch index {
        case 0:
            typeOfTransport = "Bus"
        case 1:
            typeOfTransport = "Train"
        case 2:
            typeOfTransport = "Plane"
        default:
            fatalError("Impossible index in SegmentedControl!")
        }
        imageIV.image = UIImage(named: typeOfTransport)
        routes = DataOperator.getInstance().loadRouteData(originCity: originCity, destinationCity: destinationCity, typeOfTransport: typeOfTransport)
        tableTV.reloadData()
    }
}
