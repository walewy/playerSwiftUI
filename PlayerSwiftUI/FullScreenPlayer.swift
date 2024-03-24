//
//  FullScreenPlayer.swift
//  PlayerSwiftUI
//
//  Created by Александр Калашников on 24.03.2024.
//

import Foundation
import AVKit
import SwiftUI

struct FullScreenPlayerView: View {
    
    @ObservedObject var viewModel: VideoPlayerViewModel
    
    var body: some View {
        VStack {
            ZStack{
                VideoPlayer(viewModel: viewModel)
                    .onTapGesture {
                        viewModel.showControls = true
                    }
                
                if viewModel.showControls {
                    Controls(viewModel: viewModel)
                }
                
            }
        }
        .edgesIgnoringSafeArea([.bottom, .top])
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
