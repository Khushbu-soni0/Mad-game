//
//  GameUtility.swift
//  Number Guess Game
//
//  Created by Student on 2020-02-21.
//  Copyright © 2020 Kaiyum. All rights reserved.
//

import AVFoundation

public final class GameUtility{
    var BgAudio : String = "bg.mp3"
    var bgAudioPlayer : AVAudioPlayer!
    
    var highestScore : Int!
    
    
    public func PlayBgAudio(){

        do{
            if let fileURL = Bundle.main.path(forResource: "bg.mp3", ofType: nil){
                 bgAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                bgAudioPlayer.play()
            }else{
                print("bg Audio not found")
            }
            }catch let error {
                print("Can't play the audio file failed with an error \(error.localizedDescription)")
                
        }

//         do {
//             bgAudioPlayer = try AVAudioPlayer(contentsOf: url)
//            if((bgAudioPlayer?.prepareToPlay())!){
//                bgAudioPlayer?.play()
//
//            }
//            else{
//                print("not ready")
//            }
//         } catch {
//             // couldn't load file :(
//            print("Can't load")
//         }
    }
}
