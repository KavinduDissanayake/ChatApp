//
//  LocationView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI
import MapKit

import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.glyphImage = UIImage(named: "customMarker")
            return view
        }
    }
}



struct LocationView: View {
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))))
    }
}



struct LocationMessageView: View {
    var message:Message
    var isSender = true

    var body: some View {
        VStack {
          LocationView()
                .cornerRadius(10)
        }//:VStack
        .padding(5)
        .background(isSender ? cardColor :themeColor)
        .foregroundColor(isSender ? nil : whiteColor)
        .cornerRadius(12)
        .frame(width: 180)
        .frame(height: 130)
       
         

    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            chatBackgroundColor
            LocationMessageView(message:dumyMessage,isSender: false)
        }
    }
}
