//
//  NewLocationPicker.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-15.
//

import MapKit
import SwiftUI

struct NewLocationPicker: View {
    @Binding var isShowPicker:Bool
    var confirmTapCallback:(( CLLocationCoordinate2D?) -> Void)?
    @State private var coordinates = CLLocationCoordinate2D(latitude: 7.8731, longitude:80.7718)
    @StateObject var locationManager = LocationManager()
    @State var mapView = MKMapView()
    
    @State var isShowAlert = false
    
    
    var body: some View {
        
        ZStack{
            
                 
            if isShowPicker {
                MapView(centerCoordinate: $coordinates, mapView: $mapView)
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack {
                    HStack {
                        VStack{
                            CustomButton(iconName: "ic_close",btnTapCallback: {
                                isShowPicker.toggle()
                            },iconFillColor:whiteColor)
                            .padding(.all,4)
                        }
                        .background(themeColor)
                        .cornerRadius(5)
                        .padding(.leading,10)
                      
                        Spacer()
                    }
                    
                    Spacer()
                    HStack{
                        Spacer()
                        
                        
                        Button(action: {
                            // perform action here
                            if locationManager.checkStatus() {
                                if let lastLocation  = locationManager.lastLocation {
                                    
                                    coordinates = CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
                                    
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = coordinates
                                    mapView.addAnnotation(annotation)
                                    mapView.removeAnnotations(mapView.annotations)
                                    mapView.addAnnotation(annotation)
                                    
                                }
                            }
                            
                        }) {
                            Image(systemName: "location")
                            
                                .foregroundColor(.white)
                        }
                        .frame(width: 40, height:40)
                        .background(themeColor)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .offset(x: -16, y: -16)
                    }//:HStack
                    
                    
                    // Yellow button without a border
                    LargeButton(title: "Confirm and go back",backgroundColor: themeColor) {
                      //  print("\(coordinates)")
                       if !mapView.annotations.isEmpty {
                           isShowPicker.toggle()
                           confirmTapCallback?(coordinates)
                       }else{
                           isShowAlert.toggle()
                       }
                      
                       
                    }
                    .padding(.horizontal,16)
                    
                }//VStack
                
                
           }
            
            CommonAlert(isShowAlert: $isShowAlert, alertTitle: "Select Error", alertMessage:"Please select location")
        }//:ZStack
        
        
    }
}

struct NewLocationPicker_Previews: PreviewProvider {
    static var previews: some View {
        NewLocationPicker(isShowPicker: .constant(false))
    }
}
