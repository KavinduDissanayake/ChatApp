//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI

@main
struct ChatAppApp: App {
//    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            MainTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
            
            
        }
    }
}
