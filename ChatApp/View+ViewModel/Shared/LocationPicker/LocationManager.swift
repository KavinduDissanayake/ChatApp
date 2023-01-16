//
//  LocationManager.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-15.
//

import CoreLocation
import Combine
import UIKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func reuqestLocation(){
        locationManager.requestLocation()
    }
    
    func requestWhenInUseAuthorization(){
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func showGoToSettingsAlert() {
        
            let alert = UIAlertController(title: "Location permission", message: "Location permission is denied. Do you want to go to settings?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Go to settings", style: .default, handler: { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    func checkStatus()->Bool{
        guard let status = locationStatus else { return false }
        switch status {
        case .notDetermined:
            print("not determined - hence ask for Permission")
            requestWhenInUseAuthorization()
            return false
        case .restricted, .denied:
            print("permission denied")
            showGoToSettingsAlert()
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            print("Apple delegate gives the call back here once user taps Allow option, Make sure delegate is set to self")
            return true
        default: return false
        }
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to find user's location: \(error.localizedDescription)")
    }
}
