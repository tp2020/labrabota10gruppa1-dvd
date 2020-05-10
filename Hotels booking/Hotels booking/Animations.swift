//
//  Animations.swift
//  Hotels booking
//
//  Created by Viktor on 5/10/20.
//  Copyright © 2020 Viktor. All rights reserved.
//

import Foundation
import UIKit

class Animations {
    static func moveAnimatingView(view: UIView, duration: Double, del: Double, toY: CGFloat, toX: CGFloat) {
        UIView.animate(withDuration: duration, delay: del, options: .curveEaseInOut, animations: {
            view.frame.origin.y = toY
            view.frame.origin.x = toX
        }, completion: nil)
    }
    static func shake(view: UIView){
        let coord = view.frame.origin
        Animations.moveAnimatingView(view: view, duration: 0.2, del: 0, toY: coord.y, toX: coord.x+10)
        Animations.moveAnimatingView(view: view, duration: 0.2, del: 0.2, toY: coord.y, toX: coord.x-10)
        Animations.moveAnimatingView(view: view, duration: 0.2, del: 0.4, toY: coord.y, toX: coord.x)
    }
}

