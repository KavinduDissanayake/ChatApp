//
//  BaseVM.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import Foundation


class BaseVM: ObservableObject {
    
    
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
}
