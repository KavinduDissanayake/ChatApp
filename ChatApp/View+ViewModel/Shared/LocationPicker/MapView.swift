//
//  File.swift
//  
//
//  Created by Kavindu Dissanayake on 2022-12-24.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D

    @Binding var mapView: MKMapView

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.centerCoordinate = self.centerCoordinate
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        //print(#function)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        var parent: MapView

        var gRecognizer = UITapGestureRecognizer()

        init(_ parent: MapView) {
            self.parent = parent
            super.init()
            self.gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            self.gRecognizer.delegate = self
            self.parent.mapView.addGestureRecognizer(gRecognizer)
        }

        @objc func tapHandler(_ gesture: UITapGestureRecognizer) {
            
            // position on the screen, CGPoint
            let location = gRecognizer.location(in: self.parent.mapView)
            // position on the map, CLLocationCoordinate2D
            let coordinate = self.parent.mapView.convert(location, toCoordinateFrom: self.parent.mapView)
            
            withAnimation {
                let clObject = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                parent.centerCoordinate = clObject
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = clObject
                
                withAnimation {
                    parent.mapView.removeAnnotations(parent.mapView.annotations)
                    parent.mapView.addAnnotation(annotation)
                }
                
            }
            
        }
    }
}
