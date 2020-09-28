//
//  TryViewController.swift
//  Number Guess Game
//
//  Created by Student on 2020-02-21.
//  Copyright © 2020 Kaiyum. All rights reserved.
//

import UIKit

class TryViewController: UIViewController {
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var randomNumber: UILabel!
    @IBOutlet weak var startingValue: UILabel!
    @IBOutlet weak var endingValue: UILabel!
    @IBOutlet weak var numberSlider: UISlider!
    
    @IBOutlet weak var numGenerator: UIButton!
    @IBOutlet weak var checkNumber: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var instructionBtn: UIButton!
    
    var isRandomSet : Bool = false
    let from = 0
    let to = 10
    let scope :UInt = 100
    
    var tryLevel : GameLevel!
//    @IBAction func generateNo(_ sender: Any) {
//    }
//    @IBAction func checkNo(_ sender: Any) {
//    }
//    @IBAction func reset(_ sender: Any) {
//    }
//    @IBAction func goToSetting(_ sender: Any) {
//    }
//    @IBAction func goToInstruction(_ sender: Any) {
//    }
    
    
    fileprivate func setUI() {
        startingValue.text = String(from)
        endingValue.text = String(to)
        
        scoreLabel.text = "000"
        randomNumber.text = "---"
        
        numberSlider.minimumValue = Float(from)
        numberSlider.maximumValue = Float(to)
    }
    
    override func viewDidLoad() {
        setUI()
        
        tryLevel = GameLevel(levelNo: 1, sliderValues: RangeValues(from: from, to: to), scope: UInt(scope))
       
        _ = GameUtility().PlayBgAudio();
    }
    	
    @IBAction func SliderValueChanged(_ sender: UISlider) {
       // print(sender.value)
    }
    @IBAction func TryClicked(_ sender: UIButton) {
        let random = tryLevel.SetRandomNumber()
        SetRandomNumberLable(random: String(random))
        isRandomSet = true
    }
    
    @IBAction func CheckClicked(_ sender: UIButton) {
        let guess = Int(numberSlider.value)
    
        print("guess \(guess)")
        if(isRandomSet){
       let score = tryLevel.CaculateScore(GuessedNumber: guess)
        SetScoreLable(score: String(score))
        }else{
            print("Set random numbe first")
        }
    }
    
    @IBAction func ResetClicked(_ sender: UIButton) {
        SetRandomNumberLable(random: "---")
        
        SetScoreLable(score: "000")
        isRandomSet = false
        
    }
    
    private func SetRandomNumberLable(random : String)
    {
        
        randomNumber.text = random
    }
    
  
    private func SetScoreLable(score : String)
    {
        scoreLabel.text = score
    }
}
