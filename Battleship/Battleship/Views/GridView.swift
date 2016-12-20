//
//  OceanGrid.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-15.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

var holeSize:CGSize?

class GridView: UIView {
    private let ships:[Ship] = []
    private var holes:[[Hole]] = []
    
    private var touchedShip:Ship?
    private var collidedShips:[Ship] = []
    
    var delegate: GridViewDelegate?
    var dataSource: GridViewDataSource?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.baseColor
    }
    
    private func setup() {
        let numberOfRows:Int! = dataSource?.numberOfRows(self)
        let numberOfColumns:Int! = dataSource?.numberOfColumns(self)
        
        let holeHeight = (UIScreen.main.bounds.height - (CGFloat(numberOfRows + 1) * 10.0)) / CGFloat(numberOfRows)
        let holeWidth = (UIScreen.main.bounds.width - (CGFloat(numberOfColumns + 1) * 10.0)) / CGFloat(numberOfColumns)
        
        holeSize = CGSize(width: holeWidth, height: holeHeight)
        
        for row in 0...(numberOfRows - 1) {
            
            holes[row] = []
            
            for col in 0...(numberOfColumns - 1) {
                let x = 10.0 * CGFloat(col + 1) + CGFloat(col) * holeWidth
                let y = 10.0 * CGFloat(row + 1) + CGFloat(row) * holeHeight
                let frame = CGRect(x: x, y: y, width: holeWidth, height: holeHeight)
                
                let hole = Hole(row, col, frame: frame)
            }
        }
    }
}

protocol GridViewDelegate {
    func gridView(_ view:GridView, destroyedShip ship:Ship)
    func gridView(_ view:GridView, hitRow row:String, column: Int, point:CGPoint, wasHit:Bool)
    func gridView(_ view:GridView, confirmHitRow row:String, column: Int, point:CGPoint, wasHit:Bool)
}

protocol GridViewDataSource {
    func numberOfRows(_ view:GridView) -> Int
    func numberOfColumns(_ view:GridView) -> Int
    func numberOfBattleships(_ view:GridView) -> Int
}

extension GridView {
    
    public func lockBattleshipsPositions() -> Bool {
        isUserInteractionEnabled = false
        if !collidedShips().isEmpty {
            isUserInteractionEnabled = true
            return false
        }
        
        if touchedShipLayer != nil {
            touchedShipLayer!.showRotateControl(false)
        }
        
        return true
    }
    
    public func battleshipsPositions() -> [String:[[String:Any]]]  {
        var positions:[String:[[String:Any]]] = [:]
        
        for shipLayer in shipLayers {
            if positions[shipLayer.type!.rawValue] == nil {
                positions[shipLayer.type!.rawValue] = []
            }
            
            for holeLayer in holesUnder(shipLayer: shipLayer) {
                positions[shipLayer.type!.rawValue]!.append([ "row" : holeLayer.row])
                positions[shipLayer.type!.rawValue]!.append([ "column" : holeLayer.column])
            }
        }
        
        return positions
    }
    
    public func gridBounds() -> UIEdgeInsets {
        let topLeftHoleLayer = holeLayers[rowNames.first!]![0]
        let topRightHoleLayer = holeLayers[rowNames.first!]![columnsCount - 1]
        let bottomLeftHoleLayer = holeLayers[rowNames.last!]![0]
//        let bottomRightHoleLayer = holeLayers[rowNames.last!]![columnsCount - 1]
        
        return UIEdgeInsets(top: topLeftHoleLayer.frame.origin.y,
                            left: topLeftHoleLayer.frame.origin.x,
                            bottom: bottomLeftHoleLayer.frame.origin.y + holeHeight,
                            right: topRightHoleLayer.frame.origin.x + holeWidth)
    }
    
    public func hit(row:String, column:Int) {
        var miseed = true;
        let holeLayer = holeLayers[row]?[column]
        
        for shipLayer in shipLayers {
            if shipLayer.frame.contains(holeLayer!.frame.originCenter) {
                miseed = false
                
                holeLayer?.isHit = true
                let holes = holesUnder(shipLayer: shipLayer)
                if holes.filter({ !$0.isHit }).isEmpty {
                    let to = Position(row: holes.last!.row, column: holes.last!.column)
                    let from = Position(row: holes.first!.row, column: holes.first!.column)
                    
                    delegate?.oceanGridView(self, destroyedShip: shipLayer.type!, from: from, to: to)
                    
                    return
                }
                
                break
            }
        }
        
        delegate?.oceanGridView(self, confirmHitRow: row, column: column, point: holeLayer!.frame.originCenter, wasHit: !miseed)
    }
    
    public func animateHit(atRow row:String, column:Int, missed:Bool) {
        let holeLayer = holeLayers[row]?[column]
        
        holeLayer!.shot(missed: missed)
    }
    
    public func destroyed(_ shipType:ShipType, atPosition:Position, toPosition:Position) {
        var rowStart = rowNames.index(of: atPosition.row)! as Int
        var rowEnd = rowNames.index(of: toPosition.row)! as Int
        var colStart = atPosition.column
        var colEnd = toPosition.column
        
        if rowEnd < rowStart {
            let temp = rowEnd
            rowEnd = rowStart
            rowStart = temp
        }
        
        if colEnd < colStart {
            let temp = colEnd
            colEnd = colStart
            colStart = temp
        }
        
        let shipLayer = ShipLayer(type: shipType)
        
        let holeStartLayer = holeLayers[rowNames[rowStart]]![colStart]
        let holeEndLayer = holeLayers[rowNames[rowEnd]]![colEnd]
        
        let width = holeEndLayer.frame.origin.x - holeStartLayer.frame.origin.x + holeStartLayer.frame.width
        let height = holeEndLayer.frame.origin.y - holeStartLayer.frame.origin.y + holeStartLayer.frame.height
        
        shipLayer.frame.size = CGSize(width: width, height: height)
        
        shipLayer.backgroundColor = hitFillColor.cgColor
        shipLayer.borderColor = hitBorderColor.cgColor
        
        shipLayer.addTo(view: self, at: holeStartLayer.frame.origin)
        
        let pulseEffect = PulseAnimation(repeatCount: 0,
                                         size: shipLayer.frame.size.scale(3, 1.5),
                                         position: shipLayer.position)
        
        pulseEffect.animationDuration = 1.5
        pulseEffect.borderWidth = shipLayer.borderWidth * 2
        pulseEffect.borderColor = shipLayer.borderColor
        pulseEffect.backgroundColor = shipLayer.backgroundColor
        
        layer.addSublayer(pulseEffect)
    }
    
    private func place(shipType:ShipType, atRow row:String, atColumn col:Int) {
        let holeLayer:HoleLayer! = holeLayers[row]![col]
        let shipLayer = ShipLayer(type: shipType)
        
        shipLayer.backgroundColor = safeShipFillColor.cgColor
        shipLayer.borderColor = safeShipStrokeColor.cgColor
        
        shipLayers.append(shipLayer)
        shipLayer.addTo(view: self, at:holeLayer.frame.origin)
        setHolesOpacity(shipLayer: shipLayer, opacity: 0)
    }
    
    private func collidedShips() -> [ShipLayer] {
        var layers:[ShipLayer] = []
        for layer0 in shipLayers {
            for layer1 in shipLayers {
                if (layer0 != layer1 && layer1.frame.intersects(layer0.frame)) {
                    if !layers.contains(layer0) {
                        layers.append(layer0)
                    }
                    if !layers.contains(layer1) {
                        layers.append(layer1)
                    }
                }
            }
        }
        
        return layers
    }
    
    private func touchedShip(touch:UITouch) -> ShipLayer? {
        let point = touch.location(in: self)
        
        for shipLayer in shipLayers {
            if shipLayer.contains(layer.convert(point, to: shipLayer)) {
                return shipLayer
            }
        }
        
        return nil
    }
    
    private func touchedHole(touch:UITouch) -> HoleLayer? {
        let point = touch.location(in: self)
        
        for row in holeLayers.values {
            for holeLayer in row {
                if (holeLayer.isActive &&
                    holeLayer.contains(layer.convert(point, to: holeLayer))) {
                    return holeLayer
                }
            }
        }
        
        return nil
    }
    
    private func holesUnder(shipLayer:ShipLayer) -> [HoleLayer] {
        var holes:[HoleLayer] = []
        
        for row in holeLayers.values {
            for holeLayer in row {
                if shipLayer.frame.contains(holeLayer.frame.originCenter) {
                    holes.append(holeLayer)
                }
            }
        }
        
        return holes
    }
    
    private func setHolesOpacity(shipLayer:ShipLayer, opacity:Float) {
        for layer in holesUnder(shipLayer: shipLayer) {
            layer.opacity = opacity
        }
    }
    
    private func handleShipCollision(shipLayer:ShipLayer) {
        let tempCollidedShipLayers = collidedShips()
        
        for collidedShipLayer in tempCollidedShipLayers {
            collidedShipLayer.backgroundColor = hitFillColor.cgColor
            collidedShipLayer.borderColor = hitBorderColor.cgColor
            
            collidedShipLayers.append(collidedShipLayer)
        }
        
        for collidedShipLayer in collidedShipLayers {
            if !tempCollidedShipLayers.contains(collidedShipLayer) {
                setHolesOpacity(shipLayer: collidedShipLayer, opacity: 0)
                
                collidedShipLayer.backgroundColor = safeShipFillColor.cgColor
                collidedShipLayer.borderColor = safeShipStrokeColor.cgColor
                
                collidedShipLayers.remove(at: collidedShipLayers.index(of: collidedShipLayer)!)
            }
        }
    }
    
    var touchedPoint:CGPoint = CGPoint(x:0,y:0)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let point = touch.location(in: self)
        
        touchedPoint = point
        
        if let tempTouchedShipLayer = touchedShip(touch: touch) {
            if tempTouchedShipLayer != touchedShipLayer {
                if touchedShipLayer != nil {
                    touchedShipLayer!.showRotateControl(false)
                }
                
                tempTouchedShipLayer.showRotateControl(true)
                touchedShipLayer = tempTouchedShipLayer
            }
        } else {
            touchedShipLayer = nil
        }
        
        if touchedShipLayer != nil {
            touchedShipLayer!.showRotateControl(true)
            if touchedShipLayer!.touchedRotateControl(point: layer.convert(point, to: touchedShipLayer)) {
                touchedShipLayer!.rotate = true
                setHolesOpacity(shipLayer: touchedShipLayer!, opacity: 1)
                
                touchedShipLayer!.radians += CGFloat.pi * 90.0 / 180.0 as CGFloat
                touchedShipLayer!.setAffineTransform(CGAffineTransform(rotationAngle:touchedShipLayer!.radians))
                touchedShipLayer!.fixToBounds()
                
                // Hacky Bug Fix
                touchedShipLayer!.frame.origin.x = touchedShipLayer!.frame.origin.x
                touchedShipLayer!.frame.origin.y = touchedShipLayer!.frame.origin.y
                
                setHolesOpacity(shipLayer: touchedShipLayer!, opacity: 0)
                handleShipCollision(shipLayer: touchedShipLayer!)
                return
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        if touchedShipLayer != nil {
            if touchedShipLayer!.rotate {
                touchedShipLayer!.rotate = false
                return
            }
        } else {
            if let holeLayer = touchedHole(touch: touch) {
                delegate?.oceanGridView(self, hitRow: holeLayer.row, column: holeLayer.column, point:holeLayer.frame.originCenter, wasHit: holeLayer.isHit)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        if touchedShipLayer != nil {
            if touchedShipLayer!.rotate {
                return
            }
            setHolesOpacity(shipLayer: touchedShipLayer!, opacity: 1)
            
            // Snap ship to position
            let holeLayer = touchedHole(touch: touch)
            if holeLayer != nil {
                let originalOrigin = touchedShipLayer!.frame.origin
                touchedShipLayer!.frame.origin = holeLayer!.frame.origin
                if touchedShipLayer!.outOfBounds() {
                    touchedShipLayer!.frame.origin = originalOrigin
                }
            }
            
            handleShipCollision(shipLayer: touchedShipLayer!)
            setHolesOpacity(shipLayer: touchedShipLayer!, opacity: 0)
            for collidedShipLayer in collidedShipLayers {
                setHolesOpacity(shipLayer: collidedShipLayer, opacity: 0)
            }
        }
    }
}
