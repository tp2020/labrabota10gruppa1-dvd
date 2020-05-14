//
//  RouteController.swift
//  Hotels booking
//
//  Created by Viktor on 5/15/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class RouteController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var confirmBt: UIButton!
    
    @IBOutlet weak var tableTV: UITableView!
    @IBOutlet weak var segmentedSC: UISegmentedControl!
    @IBOutlet weak var imageIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmBt.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //element amounts
        return 3
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
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainController
        self.navigationController?.pushViewController(firstVC, animated: true)
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
    
    
}
