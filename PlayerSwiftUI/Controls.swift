//
//  ControlsView.swift
//  PlayerSwiftUI
//
//  Created by Александр Калашников on 24.03.2024.
//

import Foundation
import AVKit
import SwiftUI

struct Controls: View {
    
    @ObservedObject var viewModel: VideoPlayerViewModel
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    // Тогглим полноэкранный режим
                    viewModel.isFullScreen.toggle()
                }) {
                    Image(systemName: viewModel.isFullScreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }
                
                Spacer()
            }
            Spacer()
            HStack{
                Button {
                    viewModel.player.seek(to: CMTime(seconds: self.getSeconds() - 10, preferredTimescale: 1))
                    
                } label: {
                    Image(systemName: "gobackward.10")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(20)
                }
                Spacer()
                Button {
                    if viewModel.isPlaying {
                        viewModel.pause()
                        viewModel.isPlaying = false
                    } else {
                        viewModel.play()
                        viewModel.isPlaying = true
                    }
                    
                } label: {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(20)
                }
                Spacer()
                Button {
                    viewModel.player.seek(to: CMTime(seconds: self.getSeconds() + 10, preferredTimescale: 1))
                    
                } label: {
                    Image(systemName: "goforward.10")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(20)
                }
            }
            Spacer()
            
            HStack{
                Text("\(viewModel.getTimeString(from: viewModel.player.currentTime()))")
                    .foregroundColor(.white)
                
                CustomProgressBar(viewModel: viewModel)
                
                Text("\(Int(viewModel.getTimeString(from: viewModel.player.currentItem?.duration ?? CMTime.zero))! - Int(viewModel.getTimeString(from: viewModel.player.currentTime()))!)")
                    .foregroundColor(.white)
                
            }
            
        }
        .padding()
        .background(Color.black.opacity(0.4))
        .onTapGesture {
            viewModel.showControls = false
        }
        .onAppear {
            viewModel.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { (_) in
                viewModel.value = self.getSliderValue()
                
                if viewModel.value == 1.0 {
                    viewModel.isPlaying = false
                }
            }
        }
    }
    
    func getSliderValue() -> Float {
        return Float(viewModel.player.currentTime().seconds / (viewModel.player.currentItem?.duration.seconds)!)
    }
    
    func getSeconds() -> Double {
        return Double(Double(viewModel.value) * (viewModel.player.currentItem?.duration.seconds)!)
    }
}
