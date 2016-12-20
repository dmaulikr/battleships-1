//
//  OptionsView.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-16.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

class OptionsView: ActionView {
    
    var onRestartGameTapped:() -> () = {() in }
    var onResignGameTapped:() -> () = {() in }
    var onReturnToGameTapped:() -> () = {() in }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func restartGameTapped(_ sender: UIButton) {
        onResignGameTapped()
    }
    
    @IBAction func resignGameTapped(_ sender: UIButton) {
        onResignGameTapped()
    }
    
    @IBAction func returnToGameTapped(_ sender: UIButton) {
        hide()
        
        onReturnToGameTapped()
    }
}
