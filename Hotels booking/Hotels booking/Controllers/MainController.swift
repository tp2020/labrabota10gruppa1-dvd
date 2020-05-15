//
//  MainController.swift
//  Hotels booking
//
//  Created by Viktor on 5/14/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import CoreData

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var listTV: UITableView!
    @IBOutlet weak var createNewResrvationBt: UIButton!
    
    var reservations: [NSManagedObject] = []
    var login: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewResrvationBt.layer.cornerRadius = 12
        self.hideNavigationBar()
        
        reservations = DataOperator.getInstance().loadReservationData(forLogin: login)
        listTV.delegate = self
        listTV.dataSource = self
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.hideNavigationBar()
        listTV.reloadData()
    }
    	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Reservations"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationCustomCell") as! ReservationTableViewCell
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 2
        
        let reservation = reservations[indexPath.row]
        cell.cityLb.text = ((reservation.value(forKey: "hotel") as! NSManagedObject).value(forKey: "city") as! String)
        cell.dateLb.text = (reservation.value(forKey: "time") as! String)
        cell.hotelNameLb.text = ((reservation.value(forKey: "hotel") as! NSManagedObject).value(forKey: "name") as! String)
        cell.priceLb.text = String(reservation.value(forKey: "totalPrice") as! Int)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        passData(num: indexPath.item)
    }
    
    func passData(num: Int) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "ReservationVC") as! ReservationController
        firstVC.reservation = reservations[num]
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    
    @IBAction func createNewReservationBtPressed(_ sender: Any) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "HotelsVC") as! HotelsController
        firstVC.login = login
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
}
