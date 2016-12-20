//
//  ShipLayer.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-16.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

class ShipLayer: CALayer {
    var rotate:Bool = false
    var radians:CGFloat = 0
    
    private var oceanGridView:OceanGridView?
    private let rotateControlLayer = CALayer()
    
    init(type: ShipType) {
        self.type = type
        super.init()
        
        borderWidth = 1.5
        cornerRadius = holeSize!.width/2.0
        
        
        let height = holeSize!.height * CGFloat(holesCount()) + CGFloat(10 * (holesCount() - 1))
        frame.size = CGSize(width: holeSize!.width, height: height)
        
        setupRotateControl()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRotateControl() {
        rotateControlLayer.contents = UIImage(named: "rotate")?.cgImage
        
        let center = frame.center
        let boundsCenter = bounds.center
        
        let width = holeSize!.width * 0.8
        let height = holeSize!.height * 0.8
        
        rotateControlLayer.frame.size = CGSize(width: width, height: height)
        if Int(boundsCenter.x) != Int(center.x) {
            rotateControlLayer.frame.origin = CGPoint(x: center.y - height/2.0, y: center.x - width/2.0)
        } else {
            rotateControlLayer.frame.origin = CGPoint(x: center.x - width/2.0, y: center.y - height/2.0)
        }
        
        rotateControlLayer.isHidden = true
        
        addSublayer(rotateControlLayer)
    }
    
    func setDestroyed() {
        let xLayer = CALayer()
        xLayer.contents = UIImage(named: "white-x")?.cgImage
        
        let h = holeSize!.height * 0.5
        let w = holeSize!.width * 0.5
        xLayer.frame.size = CGSize(width: w, height: h)
        
        let c = frame.center
        xLayer.frame.origin = CGPoint(x: c.x - w/2.0, y: c.y - h/2.0)
        
        addSublayer(xLayer)
    }
    
    func addTo(view: OceanGridView, at point:CGPoint)  {
        if oceanGridView != view {
            oceanGridView = view
        }
        
        frame.origin = point
        
        oceanGridView?.layer.addSublayer(self)
    }
    
    func showRotateControl(_ show:Bool) {
        rotateControlLayer.isHidden = !show
    }
    
    func touchedRotateControl(point:CGPoint) -> Bool {
        return !rotateControlLayer.isHidden ? rotateControlLayer.contains(convert(point, to: rotateControlLayer)) : false
    }
}
