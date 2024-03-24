//
//  PlayerViewModel.swift
//  PlayerSwiftUI
//
//  Created by Александр Калашников on 24.03.2024.
//

import Foundation
import AVKit
import SwiftUI

class VideoPlayerViewModel: ObservableObject {
    @Published var player = AVPlayer(url: URL(string: "https://filmoment.ru/web/loads/video/beekeeper.mp4")!)
    @Published var isPlaying = false
    @Published var showControls = false
    @Published var value: Float = 0
    @Published var isFullScreen = false
    
    func play() {
        player.play()
        isPlaying = true
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func seek(to time: Double) {
        let cmTime = CMTime(seconds: time, preferredTimescale: 1)
        player.seek(to: cmTime)
    }
    
    func getCurrentTime() -> Double {
        return player.currentTime().seconds
    }
    
    func getDuration() -> Double? {
        return player.currentItem?.duration.seconds
    }
    
    func calculateSliderValue() -> Float {
        guard let duration = getDuration(), duration > 0 else {
            return 0
        }
        return Float(getCurrentTime() / duration)
    }
}
