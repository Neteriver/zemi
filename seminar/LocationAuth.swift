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
    
    // 認証可能な座標定義
    var authenticationCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 43.061092, longitude: 141.356433)
    var result : Bool = false
    
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
    func auth(complation : @escaping(LocationAuthData) -> Void) {
        let data = LocationAuthData()
        switch authorizationStatus {
        case .notDetermined:
            requestPermission()
            break
        case .restricted:
            data.message = "位置情報の使用が制限されています"
            data.result = false
            complation(data)
            break
        case .denied:
            data.message = "位置情報を使用できません。"
            data.result = false
            complation(data)
            break
        case .authorizedAlways, .authorizedWhenInUse:
            print("緯度：" + String(coordinate?.latitude ?? 0))
            print("経度：" + String(coordinate?.longitude ?? 0))
            result = contains(coordinate: coordinate!)
            if result {
                print("GPS認証が完了しました")
                DispatchQueue.main.async {
                    data.message = "GPS認証が成功しました"
                    data.result = true
                    complation(data)

                }
            } else {
                print("GPS認証が失敗しました")
                DispatchQueue.main.async {
                    data.message = "GPS認証が失敗しました"
                    data.result = false
                    complation(data)
                }
            }
            break
        default:
            break
        }
    }
    
    // 現在の位置情報と承認可能なポイントの座標感の距離を測定
    // 座標間の距離が30m以内であれば認証可能
    func contains(coordinate:CLLocationCoordinate2D) -> Bool {
        let currentPoint:MKMapPoint = MKMapPoint(coordinate);
        let authenticaitonPoint:MKMapPoint = MKMapPoint(authenticationCoordinate);
        let distance:CLLocationDistance = currentPoint.distance(to: authenticaitonPoint);
        print(distance)
        if distance <= 3000 {
            return true
        }
        return false
    }
}
