//
//  Ship.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-23.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

class Ship {
    
    private let layer:CALayer = CALayer()
    
    var isDestroyed:Bool = false
    var isHorizontal:Bool = false
    var gridView:GridView {
        didSet {
            gridView.layer.addSublayer(layer)
        }
    }
    
    init(_ holes:Int) {
        
    }
    
    public func update() {
        if isDestroyed {
            layer.borderColor = UIColor.hitBorderColor.cgColor
            layer.backgroundColor = UIColor.hitFillColor.cgColor
        } else {
            layer.borderColor = UIColor.safeShipFillColor.cgColor
            layer.backgroundColor = UIColor.safeShipFillColor.cgColor
        }
    }
    
    func outOfBounds() -> Bool  {
        let bounds:UIEdgeInsets! = gridView.gridBounds()
        
        return round(layer.frame.origin.x) < bounds.left ||
            round(layer.frame.origin.x) + layer.frame.width > bounds.right ||
            round(layer.frame.origin.y) < bounds.top ||
            round(layer.frame.origin.y) + layer.frame.height > bounds.bottom
    }
    
    func fixToBounds()  {
        let bounds:UIEdgeInsets! = gridView.gridBounds()
        
        if layer.frame.origin.x < bounds.left {
            layer.frame.origin.x = bounds.left
        } else if layer.frame.origin.x + layer.frame.width > bounds.right {
            layer.frame.origin.x = bounds.right - layer.frame.width
        } else if layer.frame.origin.y < bounds.top {
            layer.frame.origin.y = bounds.top
        } else if layer.frame.origin.y + layer.frame.height > bounds.bottom {
            layer.frame.origin.y = bounds.bottom - layer.frame.height
        } else {
            // nothing to do
        }
    }
}
