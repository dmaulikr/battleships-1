//
//  SetupView.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-16.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit

class SetupView: ActionView {
    
    var onReadyTapped:() -> () = {() in }
    var onQuitTapped:() -> () = {() in }
    
    @IBOutlet private weak var statusLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func readyTapped(_ sender: UIButton) {
        onReadyTapped()
    }
    
    @IBAction func quitTapped(_ sender: UIButton) {
        onQuitTapped()
    }
    
}
