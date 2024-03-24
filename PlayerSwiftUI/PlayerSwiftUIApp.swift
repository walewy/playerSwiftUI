//
//  PlayerSwiftUIApp.swift
//  PlayerSwiftUI
//
//  Created by Александр Калашников on 24.03.2024.
//

import SwiftUI

@main
struct PlayerSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
