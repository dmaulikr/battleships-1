//
//  Position.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-23.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

let PositionZero = Position(0, 0)

struct Position {
    var row:Int
    var column:Int
    
    init(_ r:Int, _ c:Int) {
        row = r
        column = c
    }
}
