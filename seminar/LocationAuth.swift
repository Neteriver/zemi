//
//  LocationAuth.swift.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/09.
//

import CoreLocation
import Foundation
import MapKit

class LocationAuth:NSObject,ObservableObject,CLLocationManagerDelegate {
    
    var hcsCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 43.05605231592795, longitude: 141.37971392475367)
    
    let reason = "位置情報が取得できません"
    var coordinate: CLLocationCoordinate2D? {
        lastSeenLocation?.coordinate
    }
    @Published var authorizationStatus:CLAuthorizationStatus
    @Published var lastSeenLocation:CLLocation?
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
    }
    
    // GPS認証
    func auth(complation:@escaping(String) -> Void) {        
        switch authorizationStatus {
        case .notDetermined:
            requestPermission()
            break
        case .restricted:
            complation("位置情報の使用が制限されています")
            break
        case .denied:
            complation("位置情報を使用できません。")
            break
        case .authorizedAlways, .authorizedWhenInUse:
            print("緯度：" + String(coordinate?.latitude ?? 0))
            print("経度：" + String(coordinate?.longitude ?? 0))
            var result = contains(coordinate: coordinate!)
            complation("位置情報を取得しました")
            break
        default:
            break
        }
    }
    
    func contains(coordinate:CLLocationCoordinate2D) -> Bool {
        let point1:MKMapPoint = MKMapPoint(coordinate);
        let point2:MKMapPoint = MKMapPoint(hcsCoordinate);
        let distance:CLLocationDistance = point1.distance(to: point2);
        print(distance)
        return true
    }
}
