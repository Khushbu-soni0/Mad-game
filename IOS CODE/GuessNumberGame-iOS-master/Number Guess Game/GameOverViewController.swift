//
//  GameOverViewController.swift
//  Number Guess Game
//
//  Created by Student on 2020-02-21.
//  Copyright © 2020 Kaiyum. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet private weak var gameOverLabel: UILabel!
    @IBOutlet private weak var currentScore: UILabel!
    @IBOutlet private weak var highestScore: UILabel!
    @IBOutlet private weak var resetBtn: UIButton!
    
    var gameScore : Int!
    
    @IBAction func reset(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        if let score = gameScore {
            currentScore.text = String(score)
        }else{
            currentScore.text = String(0)
        }
        
        if let highScore = GameUtility().highestScore {
            highestScore.text = String(highScore)
        }
    }
}
