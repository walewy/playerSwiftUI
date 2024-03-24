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
    
    @State var player = AVPlayer(url: URL(string: "https://mem-tube.ru/web/loads/video/NOOOOOOOOOOOO.mp4")!)
    @State var isPlaying = false
    @State var showControls = false
    
    var body: some View {
        VStack {
            
            ZStack{
                VideoPlayer(player: $player)
                
                if self.showControls {
                    Controls(player: self.$player, isPlaying: self.$isPlaying, pannel: self.$showControls)
                }
                
            }
            .frame(height: UIScreen.main.bounds.height / 3.5)
            .onTapGesture {
                self.showControls = true
            }
            
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            self.player.play()
            self.isPlaying = true
        }
    }
}

struct Controls: View {
    
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var pannel: Bool
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Button {
                    
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(20)
                }
                Spacer()
                Button {
                    if self.isPlaying {
                        self.player.pause()
                        self.isPlaying = false
                    } else {
                        self.player.play()
                        self.isPlaying = true
                    }
                    
                } label: {
                    Image(systemName: self.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(20)
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(20)
                }
            }
            
            Spacer()
            
        }
        .padding()
        .background(Color.black.opacity(0.4))
        .onTapGesture {
            self.pannel = false
        }
    }
}

struct VideoPlayer: UIViewControllerRepresentable {
    @Binding var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resize
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

#Preview {
    ContentView()
}
