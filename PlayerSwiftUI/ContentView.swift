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
    
    @State var player = AVPlayer(url: URL(string: "https://filmoment.ru/web/loads/video/beekeeper.mp4")!)
    @State var isPlaying = false
    @State var showControls = false
    @State var value: Float = 0
    @State var isFullscreen = false
    
    var body: some View {
        GeometryReader{ geo in
            VStack {
                ZStack{
                    VideoPlayer(player: $player)
                    
                    if self.showControls {
                        Controls(player: self.$player, isPlaying: self.$isPlaying, pannel: self.$showControls, value: self.$value, isFullscreen: self.$isFullscreen)
                    }
                    
                }
                .frame(height: self.isFullscreen ? geo.size.height : (UIDevice.current.orientation.isLandscape ? geo.size.height : geo.size.height / 3))
//                .frame(height: UIDevice.current.orientation.isLandscape ? geo.size.height : geo.size.height / 3)
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
            .gesture(DragGesture().onEnded({ gesture in
                if abs(gesture.translation.width) > 100 {
                    self.isFullscreen.toggle()
                }
            }))
        }
    }
}

struct Controls: View {
    
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var pannel: Bool
    @Binding var value: Float
    @Binding var isFullscreen: Bool
    
    var body: some View {
        VStack{
            HStack {
                Button {
                    isFullscreen.toggle()
                } label: {
                    Image(systemName: isFullscreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(20)
                }
                Spacer()
            }
            Spacer()
            HStack{
                Button {
                    
                    self.player.seek(to: CMTime(seconds: self.getSeconds() - 10, preferredTimescale: 1))
                    
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
                    
                    self.player.seek(to: CMTime(seconds: self.getSeconds() + 10, preferredTimescale: 1))
                    
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(20)
                }
            }
            Spacer()
            
            CustomProgressBar(value: self.$value, player: self.$player, isPlaying: self.$isPlaying)
            
        }
        .padding()
        .background(Color.black.opacity(0.4))
        .onTapGesture {
            self.pannel = false
        }
        .onAppear {
            self.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { (_) in
                self.value = self.getSliderValue()
                
                if self.value == 1.0 {
                    self.isPlaying = false
                }
            }
        }
    }
    
    func getSliderValue() -> Float {
        return Float(self.player.currentTime().seconds / (self.player.currentItem?.duration.seconds)!)
    }
    
    func getSeconds() -> Double {
        return Double(Double(self.value) * (self.player.currentItem?.duration.seconds)!)
    }
}



struct CustomProgressBar: UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return CustomProgressBar.Coordinator(parent1: self)
    }
    
    
    @Binding var value: Float
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor  = .gray
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.changed(slider:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }
    
    class Coordinator: NSObject {
        var parent: CustomProgressBar
        init(parent1: CustomProgressBar) {
            parent = parent1
        }
        
        @objc func changed(slider: UISlider) {
            if slider.isTracking {
                parent.player.pause()
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
                
            } else {
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
                
                if parent.isPlaying {
                    parent.player.play()
                }
            }
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
