//
//  CustomProgressBar.swift
//  PlayerSwiftUI
//
//  Created by Александр Калашников on 24.03.2024.
//

import Foundation
import AVKit
import SwiftUI

struct CustomProgressBar: UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return CustomProgressBar.Coordinator(parent1: self)
    }
    
    
    @ObservedObject var viewModel: VideoPlayerViewModel
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor  = .gray
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.thumbTintColor = .red
        slider.value = viewModel.value
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.changed(slider:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = viewModel.value
    }
    
    class Coordinator: NSObject {
        var parent: CustomProgressBar
        init(parent1: CustomProgressBar) {
            parent = parent1
        }
        
        @objc func changed(slider: UISlider) {
            if slider.isTracking {
                parent.viewModel.player.pause()
                let sec = Double(slider.value * Float((parent.viewModel.player.currentItem?.duration.seconds)!))
                
                parent.viewModel.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
                
            } else {
                let sec = Double(slider.value * Float((parent.viewModel.player.currentItem?.duration.seconds)!))
                
                parent.viewModel.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
                
                if parent.viewModel.isPlaying {
                    parent.viewModel.player.play()
                }
            }
        }
    }
}
