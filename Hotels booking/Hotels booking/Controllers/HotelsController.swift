//
//  HotelsController.swift
//  Hotels booking
//
//  Created by Viktor on 5/14/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit
import CoreData

class HotelsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var listTV: UITableView!
    @IBOutlet weak var segmentationSC: UISegmentedControl!
    @IBOutlet weak var confirmBt: UIButton!
    
    @IBOutlet weak var imageIV: UIImageView!
    
    var currentIndex: Int = -1
    var hotels = [NSManagedObject]()
    var login = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmBt.layer.cornerRadius = 12
        let font = UIFont.systemFont(ofSize: 18)
        segmentationSC.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        self.showNavigationBar()
        loadHotelData()
        listTV.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //element amounts
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    
    func loadHotelData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
            }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Hotel")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "city", ascending: true)]
        var requestHotels = [NSManagedObject]()
        
        do {
            requestHotels = try managedContext.fetch(fetchRequest)
            hotels += requestHotels.filter({(object) -> Bool in
                                        object.value(forKey: "numbOfStRooms") as? Int != 0 ||
                                            object.value(forKey: "numbOfLuxRooms") as? Int != 0})
        }
        catch let error as NSError {
            print("Can't retrieve hotels: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hotels list"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        if(hotels[currentIndex].value(forKey: "numbOfLuxRooms") as! Int == 0){
            segmentationSC.setEnabled(false, forSegmentAt: 1)
        }
        if(hotels[currentIndex].value(forKey: "numbOfStRooms") as! Int == 0){
            segmentationSC.setEnabled(false, forSegmentAt: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "hotelCustomCell") as! HotelsTableViewCell
        let hotel = hotels[indexPath.row]
        cell.cityLb.text = hotel.value(forKey: "city") as? String
        cell.hotelNameLb.text = hotel.value(forKey: "name") as? String
        cell.infoLb.text = hotel.value(forKey: "info") as? String
        let luxPrice = hotel.value(forKey: "luxPrice") as! Int
        let standardPrice = hotel.value(forKey: "standardPrice") as! Int
        cell.minMaxPriceLb.text = "Standard: \(standardPrice), Lux: \(luxPrice)"
        
        return cell
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        let index = segmentationSC.selectedSegmentIndex
        if(index == 0){
            imageIV.image = UIImage(named: "standart")
        }else{
            imageIV.image = UIImage(named: "hotels")
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapController
        if(segmentationSC.selectedSegmentIndex == 0){
            firstVC.typeOfRoom = "Standard"
        }
        else{
            firstVC.typeOfRoom = "Lux"
        }
        firstVC.login = login
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    
}
