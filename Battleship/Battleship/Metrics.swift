//
//  Metrics.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-16.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

extension CGRect {
    var center:CGPoint {
        get {
            return CGPoint(x: width/2.0, y: height/2.0)
        }
    }
    var originCenter:CGPoint {
        get {
            return CGPoint(x: origin.x + width/2.0, y: origin.y + height/2.0)
        }
    }
}

extension CGSize {
    func scale(_ s:CGFloat) -> CGSize {
        return CGSize(width: width * s, height: height * s)
    }
    
    func scale(_ sx:CGFloat, _ sy:CGFloat) -> CGSize {
        return CGSize(width: width * sx, height: height * sy)
    }
}
