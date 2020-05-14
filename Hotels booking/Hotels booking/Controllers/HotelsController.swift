//
//  HotelsController.swift
//  Hotels booking
//
//  Created by Viktor on 5/14/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class HotelsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var listTV: UITableView!
    @IBOutlet weak var segmentationSC: UISegmentedControl!
    @IBOutlet weak var confirmBt: UIButton!
    
    @IBOutlet weak var imageIV: UIImageView!
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hotels list"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! HotelsTableViewCell

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
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    
}
