//
//  SearchBar.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-16.
//

import SwiftUI

struct SearchTextBar: View {
    
    @Binding var searchText: String
    var searchAction: () -> ()
    
    var body: some View {
        HStack {
            TextField("Search ..", text:$searchText)
                .onChange(of: searchText, debounceTime: 2) { newValue in
                    // Action executed each
                    searchAction()
                }
            Image(systemName: "magnifyingglass")
                .foregroundColor(grayColor)
           }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextBar(searchText: .constant(""), searchAction: {})
    }
}
