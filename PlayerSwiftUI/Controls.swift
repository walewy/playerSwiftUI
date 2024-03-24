//
//  ControlsView.swift
//  PlayerSwiftUI
//
//  Created by Александр Калашников on 24.03.2024.
//

import Foundation
import AVKit
import SwiftUI

struct ControlsView: View {
    @ObservedObject var viewModel: VideoPlayerViewModel

    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    viewModel.isFullScreen.toggle()
                }) {
                    Image(systemName: viewModel.isFullScreen ? "arrow.down.left.and.arrow.up.right" : "arrow.up.left.and.arrow.down.right")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }
                Spacer()
            }
            Spacer()
            HStack{
                Button {
                    viewModel.seek(to: viewModel.getCurrentTime() - 10)
                } label: {
                    Image(systemName: "gobackward.10")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }
                Spacer()
                Button {
                    viewModel.isPlaying ? viewModel.pause() : viewModel.play()
                } label: {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }
                Spacer()
                Button {
                    viewModel.seek(to: viewModel.getCurrentTime() + 10)
                } label: {
                    Image(systemName: "goforward.10")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }
            }
            Spacer()
            CustomProgressBar(value: viewModel.$value, player: viewModel.$player, isPlaying: <#T##Binding<Bool>#>)
        }
        .padding()
        .background(Color.black.opacity(0.4))
        .onTapGesture {
            viewModel.showControls = false
        }
    }
}
