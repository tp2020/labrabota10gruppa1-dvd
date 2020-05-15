//
//  HotelsTableViewCell.swift
//  Hotels booking
//
//  Created by Viktor on 5/15/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class HotelsTableViewCell: UITableViewCell {
    @IBOutlet weak var infoLb: UILabel!
    @IBOutlet weak var cityLb: UILabel!
    @IBOutlet weak var minMaxPriceLb: UILabel!
    @IBOutlet weak var hotelNameLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected) {
            cityLb.backgroundColor = UIColor.green
        }
        else {
            cityLb.backgroundColor = UIColor.white
        }
    }
}
