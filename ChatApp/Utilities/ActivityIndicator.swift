//
//  ActivityIndicator.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-22.
//
import SwiftUI


/// A container type for supported Indicators.
public enum Indicator {}

/// A protocol which defines an Activity Indicator and provides some utility functions.
public protocol ActivityIndicator: View {
    /// States whether or not this activity indicator should be animating.
    var isAnimating: Bool { get }
    
    /// The current color of the activity indicator.
    var color: Color { get }
    
    /// The default size of the indicator, or nil if the indicator needs to be resizable.
    var defaultSize: CGSize? { get set }
}

extension ActivityIndicator {
    
    /// Returns the minimum between the width and the height of the given GeometryProxy.
    /// - Parameter proxy: The GeometryProxy representing the container of this Activity Indicator.
    internal func minDimension(_ proxy: GeometryProxy) -> CGFloat {
        min(proxy.size.width, proxy.size.height)
    }
    
    /// Returns the maximum between the width and the height of the given GeometryProxy.
    /// - Parameter proxy: The GeometryProxy representing the container of this Activity Indicator.
    internal func maxDimension(_ proxy: GeometryProxy) -> CGFloat {
        max(proxy.size.width, proxy.size.height)
    }
    
    /// A modifier which makes this indicator resizable. If this modifier is not followed by a .frame() modifier, then it will take up all of the the space offered to it.
    public func resizable() -> Self {
        var newView = self
        newView.defaultSize = nil
        return newView
    }
}

extension Indicator {
    public struct Continuous: ActivityIndicator {
        
        public var isAnimating: Bool = true
        //MARK: - CUSTOM COLOR
        public var color = themeColor
        
        /// The current rotation of the ball string.
        @State private var rotation: Double = 360
        /// The timer which drives the animation of this indicator.
        private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        public var defaultSize: CGSize? = CGSize(width: 40, height: 40)
        
        public var body: some View {
            GeometryReader { proxy in
                Circle()
                    .strokeBorder(
                        AngularGradient(gradient: Gradient(colors: [self.color.opacity(0), self.color]),
                                        center: .center,
                                        startAngle: .degrees(-90),
                                        endAngle: .degrees(270)),
                        lineWidth: self.lineWidth(proxy)
                    )
            }
            .rotationEffect(.degrees(self.rotation))
            .frame(width: defaultSize?.width, height: defaultSize?.height)
            .onReceive(self.timer) { _ in
                if self.isAnimating {
                    withAnimation(Animation.linear) {
                        self.rotation += 36
                    }
                }
            }
        }
        
        /// Returns the line width of the indicator.
        /// - Parameter proxy: The GeometryProxy representing the container of this Activity Indicator.
        private func lineWidth(_ proxy: GeometryProxy) -> CGFloat {
            self.minDimension(proxy) * 0.1
        }
        
        /// Creates a new Indicator of type Continuous of the given color (if given), binded to the given bool isAnimating property.
        /// - Parameters:
        ///   - isAnimating: A Binding to a Bool which controls whether or not this indicator is animating.
        ///   - color: An optional parameter which control the color of this indicator. The default value of this parameter is the primary color.
        public init(isAnimating: Bool = true, color: Color = .primary) {
            
            self.isAnimating = isAnimating
            self.color = isAnimating ? color : .clear
            
        }
    }
}

