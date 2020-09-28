//
//  GameConfig.swift
//  Number Guess Game
//
//  Created by Student on 2020-02-21.
//  Copyright © 2020 Kaiyum. All rights reserved.
//

import Foundation

final class GameConfig{
    
    enum Theme {
       case Light
       case Gray
    }
    
    var gameTheme : Theme = Theme.Light
     
    func ChangeTheme(theme:Theme) {
        gameTheme = theme
    }
    
}
