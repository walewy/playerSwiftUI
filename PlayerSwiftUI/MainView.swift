//
//  ContentVie.swift
//  PlayerSwiftUI
//
//  Created by Александр Калашников on 24.03.2024.
//

import Foundation
import SwiftUI
import AVKit

struct MainView: View {
    
    @StateObject var viewModel = VideoPlayerViewModel()
    
    var body: some View {
        VStack {
            VideoPlayerView(viewModel: viewModel)
        }
    }
}
