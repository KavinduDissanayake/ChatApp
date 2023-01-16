//
//  LocationView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import SwiftUI
import MapKit

import MapKit

//struct MapView: UIViewRepresentable {
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
//        mapView.addAnnotation(annotation)
//
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
//            view.glyphImage = UIImage(named: "customMarker")
//            return view
//        }
//    }
//}
//
struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

struct PinAnnotationMapView: View {
    let place: IdentifiablePlace
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.location.latitude, longitude: place.location.longitude), latitudinalMeters: 100000, longitudinalMeters: 100000)),
            annotationItems: [place])
        { place in
            MapMarker(coordinate: place.location,
                   tint: themeColor)
        }
    }
}



struct LocationMessageView: View {
    var message:Message
    var isSender = true

    @State var showLocationView : Bool = false
    var body: some View {
        ZStack {
            VStack {
                PinAnnotationMapView(place: IdentifiablePlace(lat: Double(message.location?.latitude ?? "0.0") ?? 0,long:  Double(message.location?.longitude ??  "0.0") ?? 0))
                    .cornerRadius(10)
                    .onTapGesture {
                        showLocationView.toggle()
                    }
                
            }//:VStack0
            .padding(5)
            .background(isSender ? cardColor :themeColor)
            .foregroundColor(isSender ? nil : whiteColor)
            .cornerRadius(12)
            .frame(width: 180)
            .frame(height: 130)
            .padding(.top,2)
            
            Text("")
                .sheet(isPresented: $showLocationView) {
            
                    ZStack {
                        PinAnnotationMapView(place: IdentifiablePlace(lat: Double(message.location?.latitude ?? "0.0") ?? 0,long:  Double(message.location?.longitude ??  "0.0") ?? 0))
                            .edgesIgnoringSafeArea(.vertical)
                        
                        VStack {
                            HStack {
                                VStack{
                                    CustomButton(iconName: "ic_close",btnTapCallback: {
                                        showLocationView.toggle()
                                    },iconFillColor:whiteColor,size: 18)
                                    .padding(.all,4)
                                }
                                .background(themeColor)
                                .cornerRadius(5)
                                .padding(.leading,10)
                                .padding(.top,10)
                              
                                Spacer()
                            }//:HStack
                            
                            Spacer()
                        }//:VStack
                    }
            }
            
        }//ZStack
       
         

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
