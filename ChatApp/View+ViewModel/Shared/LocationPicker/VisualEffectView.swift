//
//  VisualEffectView.swift
//  
//
//  Created by Kavindu Dissanayake on 2022-12-24.
//

import Foundation
import SwiftUI

// Blur effect for SwiftUI 2.0
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
