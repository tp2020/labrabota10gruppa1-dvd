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

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if (highlighted) {
            textLabel?.backgroundColor = UIColor.green
        }
        else {
            textLabel?.backgroundColor = UIColor.white
        }
    }
}
