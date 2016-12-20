//
//  ViewController.swift
//  Battleship
//
//  Created by Karim Kawambwa on 2016-10-15.
//  Copyright © 2016 Karim Kawambwa. All rights reserved.
//

import UIKit
import Foundation

class GameController: UIViewController {

    @IBOutlet weak var opponentOceanGrid: OceanGridView!
    @IBOutlet weak var playerOceanGrid: OceanGridView!
    
    @IBOutlet weak var attemptCountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var playerOceanGridHeightConstraintConstant: NSLayoutConstraint!
    
    @IBOutlet weak var menuButton: UIButton!
    
    private let maxAttempts:Int = 94
    private var opponentAttempts:Int = 0
    
    private var optionsView:OptionsView!
    private var setupView:SetupView!
    
    var timeToStart = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.07,
                                       green: 0.09,
                                       blue: 0.09,
                                       alpha: 1.00)
        
        playerOceanGrid.delegate = self
        opponentOceanGrid.delegate = self
        
        optionsView = .fromNib() as OptionsView
        setupView = .fromNib() as SetupView
        
        
        setupView.onReadyTapped = { [unowned self] () in
            if self.playerOceanGrid.lockBattleshipsPositions() {
                self.setupView.hide()
            }
        }
        
        setupView.onQuitTapped = { [unowned self] () in
            self.setupView.hide()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playerOceanGrid.setup()
//        Timer.scheduledTimer(timeInterval: 1.0,
//                             target: self,
//                             selector: #selector(GameController.countdown),
//                             userInfo: nil,
//                             repeats: true)
        
        setupView.frame.size.height = UIScreen.main.bounds.height - opponentOceanGrid.frame.origin.y
        setupView.show(inView: view, blockUI:false, animated: false)
    }
    
    func countdown(timer: Timer) {
        timeToStart -= 1
        if timeToStart <= 0 {
            timer.invalidate()
        }
        
        statusLabel.text = "Battle begins in \(timeToStart) ..."
    }
    
    func recordAttempt() {
        opponentAttempts += 1
        attemptCountLabel.text = "\(opponentAttempts)/\(maxAttempts)"
    }
    
    @IBAction func showGameOptionsTapped(_ sender: UIButton) {
        optionsView.show(inView: view)
    }
}

extension GameController: GridViewDataSource {
    
    func numberOfRows(_ view: GridView) -> Int {
        return 8
    }
    
    func numberOfColumns(_ view: GridView) -> Int {
        return 11
    }
    
    func numberOfBattleships(_ view: GridView) -> Int {
        return 5
    }
    
}
