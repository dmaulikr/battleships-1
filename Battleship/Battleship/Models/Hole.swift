//
//  Hole.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-23.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

class Hole {
    
    private let layer:CALayer = CALayer()
    let position:Position!
    
    var isHit:Bool {
        didSet {
            update()
            
            if isHit {
                animateHit()
            }
        }
    }
    
    init(_ row:Int, _ column:Int, frame:CGRect) {
        position.row = row
        position.column = column
        
        layer.borderWidth = 1.5
        layer.frame.size = frame.size
        layer.frame.origin = frame.origin
        layer.cornerRadius = frame.width/2.0
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.borderColor = UIColor.darkBaseColor.cgColor
    }
    
    func update() {
        if isHit {
            layer.backgroundColor = UIColor.whiteFillColor.cgColor
            layer.borderColor = UIColor.white.cgColor
        } else {
            layer.backgroundColor = UIColor.hitFillColor.cgColor
            layer.borderColor = UIColor.hitBorderColor.cgColor
        }
    }
    
    private func animateHit() {
        let pulseEffect = PulseAnimation(repeatCount: 1, size: layer.frame.size.scale(3), position: layer.frame.origin)
        
        pulseEffect.animationDuration = 1.5
        pulseEffect.borderColor = layer.borderColor
        pulseEffect.borderWidth = layer.borderWidth * 2
        pulseEffect.backgroundColor = layer.backgroundColor
        
        layer.superlayer!.addSublayer(pulseEffect)
    }
}
