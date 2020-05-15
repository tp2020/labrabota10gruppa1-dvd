//
//  TableViewCell.swift
//  Hotels booking
//
//  Created by Viktor on 5/14/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

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
