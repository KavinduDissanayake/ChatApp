//
//  HomePage.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI

struct HomePage: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    
    
    var body: some View {
        
        Toggle("", isOn: $isDarkMode)
           // .toggleStyle(ColoredToggleStyle())
            // .toggleStyle(SwitchToggleStyle(tint: .ToggleRed))
            .onChange(of: isDarkMode, perform: { value in
               // Log.debug("isDarkMode => \(isDarkMode)")
                print("Test")
            })
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
