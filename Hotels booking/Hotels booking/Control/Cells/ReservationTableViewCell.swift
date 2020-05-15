//
//  RegistrationTableViewCell.swift
//  Hotels booking
//
//  Created by Viktor on 5/15/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

/*
    ReservationTableViewCell
    Cell with brief data of reservation
 */

class ReservationTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var cityLb: UILabel!
    @IBOutlet weak var hotelNameLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
