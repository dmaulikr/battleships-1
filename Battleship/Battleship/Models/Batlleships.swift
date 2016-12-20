//
//  Batlleships.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-23.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

class Carrier: Ship {
    init() {
        super.init(5)
    }
}

class Cruiser: Ship {
    let numberOfHoles:Int = 3
}

class Submarine: Ship {
    init() {
        super.init(3)
    }
}

class Destroyer: Ship {
    init() {
        super.init(3)
    }
}

class Battleship: Ship {
    init() {
        super.init(7)
    }
}
