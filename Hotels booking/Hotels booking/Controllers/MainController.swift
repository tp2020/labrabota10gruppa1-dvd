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
    var reservations: [NSManagedObject] = []
    var login:String = ""

    @IBOutlet weak var createNewResrvationBt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewResrvationBt.layer.cornerRadius = 12
        self.hideNavigationBar()
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.hideNavigationBar()
    }
    	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Reservations"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        return cell
    }
    
    func passData(num: Int) {
        //code to switch to another view by tapping on cell (if necessary)
    }
    
    
    @IBAction func createNewReservationBtPressed(_ sender: Any) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "HotelsVC") as! HotelsController
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        passData(num: indexPath.item)
    }
    
    
    func loadData(){
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Hotel")
        var tempReservations: [NSManagedObject] = []
        do {
            tempReservations = try managedContext.fetch(fetchRequest)
            for reservation in tempReservations{
                if(reservation.value(forKey: "user") as! String == login){
                    reservations.append(reservation)
                }
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

}
