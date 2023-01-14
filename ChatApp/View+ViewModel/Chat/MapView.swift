//
//  MapView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-14.
//

import MapKit
import SwiftUI

struct NewMapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @State private var selectedCoordinate: CLLocationCoordinate2D?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.mapTapped(gesture:)))
        mapView.addGestureRecognizer(gesture)
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.setCenter(centerCoordinate, animated: true)
        if let selectedCoordinate = selectedCoordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = selectedCoordinate
            view.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: NewMapView

        init(_ parent: NewMapView) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }

        @objc func mapTapped(gesture: UITapGestureRecognizer) {
            let location = gesture.location(in: gesture.view)
//            let coordinate = parent.convert(location,toCoordinateFrom: parent)
            //parent.selectedCoordinate = coordinate
        }
    }
}



struct MapView_Previews: PreviewProvider {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    static var previews: some View {
        NewMapView(centerCoordinate: .constant(CLLocationCoordinate2D()))
    }
}
