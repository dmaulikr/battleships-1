//
//  ActionView.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-16.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

class ActionView: UIView {
    var container:UIView! = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func show(inView view:UIView, blockUI:Bool = true, animated:Bool = true) {
        
        frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height)
        frame.size = CGSize(width: UIScreen.main.bounds.width, height: frame.height)
        
        if blockUI {
            container!.frame = UIScreen.main.bounds
            container!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            
            container!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OptionsView.hide)))
            
            view.addSubview(container)
        }
        
        view.addSubview(self)
        
        UIView.animate(withDuration: animated ? 0.27 : 0) {
            let y = UIScreen.main.bounds.height - self.frame.height
            self.frame.origin = CGPoint(x: 0, y: y)
        }
    }
    
    func hide() {
        container.removeFromSuperview()
        UIView.animate(withDuration: 0.27, animations: {
            self.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height)
            }, completion: { completed in
                self.removeFromSuperview()
        })
    }
}
