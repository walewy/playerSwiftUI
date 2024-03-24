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
}
