//
//  GpsView.swift
//  seminar
//
//  Created by しゅん on 2021/12/16.
//

import SwiftUI
import MapKit
import AlertToast

struct GpsView: View {
        
    @ObservedObject var locationAuth = LocationAuth()
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        if(locationAuth.result) {
            FlickAuthView()
        } else {
            if(locationAuth.isEnable) {
                ZStack {
                    Rectangle().frame(width: width, height: height, alignment: .center)
                        .foregroundColor(.black)
                        .opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer(minLength: 10.0)
                        Map(coordinateRegion: $locationAuth.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode)
                            .frame(width: width, height: height*0.30)
                            .border(Color.gray)
                        Spacer()
                        Text("").foregroundColor(.black).opacity(0.6).frame(width: width, height: height/2)
                    }

                    
                    AlertToast(type: .loading, title: "GPS認証中です", subTitle: nil)
                        .alert("GPSが一致しません", isPresented: $locationAuth.isAuthingBad) {
                            Button("了解") {
                                locationAuth.auth()
                            }
                        } message: {
                            Text("GPSが一致しません")
                        }.onAppear(perform: {
                            // GPS認証
                            locationAuth.auth()
                        })
                }
            } else {
                Text("これはダミーテキストです").foregroundColor(.white).onAppear() {
                    locationAuth.request()
                }
            }
        }
    }
}

struct GpsView_Previews: PreviewProvider {
    static var previews: some View {
        GpsView()
    }
}
