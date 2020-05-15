//
//  RouteTableViewCell.swift
//  Hotels booking
//
//  Created by Viktor on 5/15/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {
    @IBOutlet weak var companyLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var fromLb: UILabel!
    @IBOutlet weak var toLb: UILabel!
    @IBOutlet weak var departTimeLb: UILabel!
    @IBOutlet weak var arriveTimeLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
