//
//  UIView.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-16.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(NSStringFromClass(T.self).components(separatedBy: ".").last!, owner: self, options: nil)?[0] as! T
    }
}
