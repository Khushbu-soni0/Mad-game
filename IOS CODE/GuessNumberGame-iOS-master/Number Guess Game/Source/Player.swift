//
//  GameStates.swift
//  Number Guess Game
//
//  Created by Student on 2020-02-17.
//  Copyright © 2020 Kaiyum. All rights reserved.
//

import Foundation

public class Player{
    
    private var name : String
    
    init(PlayerName name:String) {
        self.name = name
    }
    
    public func GetPlayerName() -> String
    {
        return name.capitalized
    }
}
