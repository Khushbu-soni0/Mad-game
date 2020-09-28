//
//  GameLevel.swift
//  Number Guess Game
//
//  Created by Abdulkaiyum on 2020-02-17.
//  Copyright © 2020 Kaiyum. All rights reserved.
//

import Foundation

struct RangeValues : RandomNumberGenerator{
    private var min : Int
    private var max : Int
    private var randomNumber : Int!
    
    var range : ClosedRange<Int>
    
    init(from min : Int, to max : Int ) {
        self.min = min
        self.max = max
        self.range = min...max
//        default random number to mid value
        self.randomNumber = getMidNumber()
    }
    
    func getMidNumber() -> Int {
        return Int((max - min) / 2)
    }
    
    func getMin() -> Int {
        return min
    }
    
    func getMax() -> Int {
        return max
    }
    
    func SetRandomNumber() -> Int {
        var generator = SystemRandomNumberGenerator()
        return range.randomElement(using: &generator)!
    }
    
    func GetRandomNumber() -> Int {
        if let random = self.randomNumber {
            return random
        }
        else{
            return SetRandomNumber()
        }
    }
    
    func getRangeWidth() -> Int {
        return range.max()! - range.min()!
    }
}
class GameLevel {
    var levelNo : UInt
    var valueRange : RangeValues
    var randomNumber : Int!
    var scoreRange : RangeValues!
    var guessedNumber : UInt!
    var scoreScopePerc: UInt // score scope percentage 5% to 100%
    
    init(levelNo : UInt, sliderValues range : RangeValues, scope scoreScopePerc : UInt ) {
        self.levelNo = levelNo
        self.valueRange = range
        self.randomNumber = valueRange.getMidNumber()
        self.scoreScopePerc = scoreScopePerc
//        Default set to value range
        self.scoreRange = range
    }
    
    func getMinValue() -> Int {
        return valueRange.getMin()
    }
    
    func getMaxValue() -> Int {
        return valueRange.getMax()
    }
    
    func SetRandomNumber() -> Int {
//        setting up score range
        randomNumber = self.valueRange.SetRandomNumber()
        PrepareScoreRange()
       
        return randomNumber!
    }
    
    private func PrepareScoreRange(){
        var offset = ((Float(scoreScopePerc)/(2*100)) * Float(valueRange.getRangeWidth()))
        var lower = self.randomNumber! - Int(offset)
        var upper = self.randomNumber! + Int(offset)
      
        if(scoreScopePerc == 100 ){
            // Full range available to score
            lower = getMinValue()
            upper = getMaxValue()
        }
        else{
            offset = ((Float(scoreScopePerc)/(2*100)) * Float(valueRange.getRangeWidth()))
            lower = self.randomNumber! - Int(offset)
            upper = self.randomNumber! + Int(offset)
        }
        
//        print("Offset \(offset)")
//        print("rand \(self.randomNumber!)")
//        print("Lower \(lower)")
//        print("upper \(upper)")
        
        SetScoreRange(range: lower...upper)
    }
    private func SetScoreRange(range : ClosedRange<Int>) {
        self.scoreRange.range = range.clamped(to : valueRange.range)
//        print("score Range \(scoreRange.range)")
//        print("------")
    }
    
    func GetRandomNumber() -> Int {
        return self.valueRange.GetRandomNumber()
    }
    
    func CaculateScore(GuessedNumber number: Int) -> Int {
        var score : Float!
        var diff : Int
        print("Random \(randomNumber!)")
        print("number \(number)")
        print("Scope \(scoreScopePerc)")
        if(number == randomNumber!){
            score = 100
        }
        else if(number < randomNumber!){
            diff = (randomNumber! - number)
            print("Diff \(diff)")
            print(Float(scoreRange.getRangeWidth()))
            score = Float(diff * 100) / Float(scoreRange.getRangeWidth())
            score = 100 - score
        }else if (number > randomNumber!){
            diff = (number - randomNumber!)
            print("Diff \(diff)")
                 print(Float(scoreRange.getRangeWidth()))
            score = Float(number - randomNumber) * (100) / Float(scoreRange.getRangeWidth())
            score = 100 - score
        }
        print("Score --- \(score!)")
        return Int(score!)
    }
}
