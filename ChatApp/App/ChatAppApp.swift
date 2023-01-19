//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}



@main
struct ChatAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ViewRouter.shared)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
