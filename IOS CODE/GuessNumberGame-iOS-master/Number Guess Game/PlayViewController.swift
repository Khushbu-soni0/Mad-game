//
//  PlayViewController.swift
//  Number Guess Game
//
//  Created by Student on 2020-02-21.
//  Copyright © 2020 Kaiyum. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var randomNumber: UILabel!
    @IBOutlet weak var startingValue: UILabel!
    @IBOutlet weak var endingValue: UILabel!
    @IBOutlet weak var numGenerator: UIButton!
    @IBOutlet weak var checkNumber: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var instructionBtn: UIButton!
    
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var lifeImg: UIImageView!
    
    var isRandomSet : Bool = false
    var from = 0
    var to = 0
    var scope : UInt = 100
    var level : UInt = 1
    
    let tryConstant : Int = 2
    var noOfTry = 2
 
    
    var score = 0
    var tempScore : Int = 0
    
    let stepping : Int = 10
    let difficultyLevel : UInt = 10
    var difficultyTheshold : Int = 2
    
    var isSuccess : Bool = false
    
    
    var heartImages : [String] = ["heart_2","heart_2","heart_0"]
    
    var levelObj : GameLevel!

    fileprivate func setUI() {
        
        // TODO : Theme GET FROM GAMECONFIG
        
        SetScoreLable(score: String(score))
        
        randomNumber.text = "---"
        
        SetRangeLabels()
        SetSliderRangeValues()
        SetLevelLabel();
        
        UpdateTryImages()
      }
    
    func SetRangeLabels() {
        startingValue.text = String(from)
        endingValue.text = String(to)
    }
    
    func SetLevelLabel() {
        levelLabel.text = "Level " + String(level)
    }
    
    func SetSliderRangeValues() {
        numberSlider.minimumValue = Float(from)
        numberSlider.maximumValue = Float(to)
    }
    
    override func viewDidLoad() {
       setUI()
        
       GenerateLevel()
    }
    
    @IBAction func SliderValueChanged(_ sender: UISlider) {
          // print(sender.value)
       }
   @IBAction func TryClicked(_ sender: UIButton) {
       let random = levelObj.SetRandomNumber()
       SetRandomNumberLable(random: String(random))
       isRandomSet = true
   }
   
   @IBAction func CheckClicked(_ sender: UIButton) {
        let guess = Int(numberSlider.value)
   
        print("guess \(guess)")
       
        if(isRandomSet){
            let score = levelObj.CaculateScore(GuessedNumber: guess)
            
            SetScoreLable(score: String(score))
            tempScore = score
            if(score == 100){
                isSuccess = true
                level = level + 1
                GenerateLevel()
            }else{
                noOfTry = noOfTry - 1
                UpdateTryImages()
                if(noOfTry == 0){
                    performSegue(withIdentifier: "gameOver", sender: self)
                }
            }
       }else{
           print("Set random numbe first")
       }
   }
   
    @IBAction func ResetClicked(_ sender: UIButton) {
        SetRandomNumberLable(random: "---")
       
        SetScoreLable(score: "0")
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
  
    @IBAction func SettingClicked(_ sender: Any) {
    }
    @IBAction func InstructionClicked(_ sender: Any) {
    }
    
    func GenerateLevel(){
        difficultyTheshold -= 1
        GameUtility().highestScore = 0
        
        if(difficultyTheshold == 0){
            scope = scope - difficultyLevel
        }
        to = to + stepping
        levelObj = GameLevel(levelNo: level, sliderValues: RangeValues(from: from, to: to), scope: UInt(scope))
        
         _ = GameUtility().PlayBgAudio();
        
        score = score + tempScore
        setUI()
        isSuccess = false
        noOfTry = tryConstant
    }
    
    func GenerateLevels() {
        // TODO:: Create levels upfrom and load on request
    }
    
    func UpdateTryImages() {
        print("remain \(heartImages[noOfTry])")
        lifeImg.image = UIImage(named: heartImages[noOfTry])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameoverController = segue.destination as! GameOverViewController
        gameoverController.gameScore = tempScore
    }
}
