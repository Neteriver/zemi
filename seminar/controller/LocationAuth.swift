//
//  RequestLocation.swift
//  seminar
//
//  Created by しゅん on 2022/01/06.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

class LocationAuth: NSObject,CLLocationManagerDelegate, ObservableObject {
    
    // 認証可能な座標定義
    let authenticationCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 43.061092, longitude: 141.356433)
    
    let manager = CLLocationManager()
    // 非同期処理用のクロージャ
    typealias compLocation = (_ location:[String:CLLocationDegrees]) -> Void
    
    public var roomLocation:[String:CLLocationDegrees] = [:]
    
    @Published var authorizationStatus:CLAuthorizationStatus = .notDetermined
    
    // 位置情報利用フラグ
    @Published var isEnable = false
    
    // 認証結果
    @Published var result = false
    
    // 認証失敗フラグ
    @Published var isAuthingBad = false
    
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 43.0383, longitude: 131.81067894034084),
        latitudinalMeters: 300,
        longitudinalMeters: 300
    )
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func request() {
        manager.requestWhenInUseAuthorization()
    }
    
    func auth() {
        getLocation(comp: { location in
            let result = self.contains(latitude: location["roomLatitude"]!, longitude: location["roomLongitude"]!)
            self.result = result
            self.isAuthingBad = !result
        })
    }
    
    deinit {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .authorizedAlways:
            print("常に許可")
            authorizationStatus = .authorizedAlways
            isEnable = true
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("使用時のみ許可")
            authorizationStatus = .authorizedWhenInUse
            isEnable = true
            manager.startUpdatingLocation()
        case .denied:
            authorizationStatus = .denied
            isEnable = false
            print("承認拒否")
        case .notDetermined:
            authorizationStatus = .notDetermined
            isEnable = false
            print("未設定")
        case .restricted:
            authorizationStatus = .restricted
            isEnable = false
            print("機能制限")
        @unknown default:
            print("何も一致しなかったよ")
        }
     }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let roomLatitude = location.coordinate.latitude
        let roomLongitude = location.coordinate.longitude
        self.region = MKCoordinateRegion(
            center: .init(latitude: roomLatitude, longitude: roomLongitude),
            latitudinalMeters: 100,
            longitudinalMeters: 700
        )
        roomLocation = ["roomLatitude": roomLatitude, "roomLongitude": roomLongitude]
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗しました")
    }
    
    // 現在の位置情報と承認可能なポイントの座標感の距離を測定
    // 座標間の距離が30m以内であれば認証可能
    private func contains(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Bool {
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let currentPoint:MKMapPoint = MKMapPoint(locationCoordinate);
        let authenticaitonPoint:MKMapPoint = MKMapPoint(authenticationCoordinate);
        let distance:CLLocationDistance = currentPoint.distance(to: authenticaitonPoint);
        if distance <= 3000 {
            return true
        }
        return false
    }
    
    // 位置情報を取得する処理(取得できるまで0.5秒再帰)
    private func getLocation(comp:@escaping compLocation) {
        if roomLocation.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                // 4秒待機
                self.getLocation(comp: comp)
            }
        } else {
            // 位置情報を取得
            comp(roomLocation)
        }
    }
}
