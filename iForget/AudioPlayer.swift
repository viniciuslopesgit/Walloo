//
//  AudioPlayer.swift
//  iForget
//
//  Created by Vinícius Lopes on 08/09/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation
import AVKit

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    
    func startPlayback (audio: URL) {
        
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Playing over the device's speakers failed")
        }
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
    
}
