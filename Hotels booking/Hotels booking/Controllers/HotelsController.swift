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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmBt.layer.cornerRadius = 12
        let font = UIFont.systemFont(ofSize: 18)
        segmentationSC.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        self.showNavigationBar()


        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
            hotels += requestHotels
        }
        catch let error as NSError {
            print("Can't retrieve hotels: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Existing Reservations"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
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
    }
}
