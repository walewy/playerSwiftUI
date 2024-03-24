//
//  ContentVie.swift
//  PlayerSwiftUI
//
//  Created by Александр Калашников on 24.03.2024.
//

import Foundation
import SwiftUI
import AVKit

struct ContentView: View {
    
    @StateObject var viewModel = VideoPlayerViewModel()
    
    var body: some View {
        GeometryReader{ geo in
            VStack {
                ZStack{
                    VideoPlayer(viewModel: viewModel)
                    
                    if viewModel.showControls {
                        Controls(viewModel: viewModel)
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 3)
                .onTapGesture {
                    viewModel.showControls = true
                }
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .fullScreenCover(isPresented: $viewModel.isFullScreen, content: {
                FullScreenPlayerView(viewModel: viewModel)
            })
            .onAppear {
                viewModel.player.pause()
                viewModel.isPlaying = false
            }
            .onChange(of: viewModel.isFullScreen, { oldValue, newValue in
                AppDelegate.orientationLock = newValue ? .all : .portrait
            })
            
        }
    }
}
