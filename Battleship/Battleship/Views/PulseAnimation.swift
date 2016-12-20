//
//  PulseEffect.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-16.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

class PulseAnimation: CALayer {
    
    var size:                   CGSize?
    var fromValueForRadius:     Float = 0.0
    var fromValueForAlpha:      Float = 0.45
    var keyTimeForHalfOpacity:  Float = 0.2
    var animationDuration:      TimeInterval = 3.0
    var pulseInterval:          TimeInterval = 0.0
    var useTimingFunction:      Bool = true
    var animationGroup:         CAAnimationGroup = CAAnimationGroup()
    var repetitions:            Float = Float.infinity
    
    // Need to implement that, because otherwise it can't find
    // the constructor init(layer:AnyObject!)
    // Doesn't seem to look in the super class
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    init(repeatCount: Float=Float.infinity, size: CGSize, position: CGPoint) {
        super.init()
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0.0
        self.size = size;
        self.repetitions = repeatCount;
        self.position = position
        
        DispatchQueue.global(qos: .background).async {
            self.setupAnimationGroup()
            self.setPulseSize(size: self.size!)
            
            if (self.pulseInterval != Double.infinity) {
                DispatchQueue.main.async {
                    self.add(self.animationGroup, forKey: "pulse")
                }
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPulseSize(size: CGSize) {
        self.size = size
        self.bounds = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        self.position = self.position
        self.cornerRadius = (size.width < size.height ? size.width : size.height) / 2.0
    }
    
    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = self.animationDuration + self.pulseInterval
        self.animationGroup.repeatCount = self.repetitions
        self.animationGroup.isRemovedOnCompletion = false
        
        if self.useTimingFunction {
            let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            self.animationGroup.timingFunction = defaultCurve
        }
        
        self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: self.fromValueForRadius)
        scaleAnimation.toValue = NSNumber(value: 1.0)
        scaleAnimation.duration = self.animationDuration
        
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = self.animationDuration
        opacityAnimation.values = [self.fromValueForAlpha, 0.8, 0]
        opacityAnimation.keyTimes = [0.0, 0.2, 1.0]
        opacityAnimation.isRemovedOnCompletion = false
        
        return opacityAnimation
    }
    
}
