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
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        if(locationAuth.result) {
            FlickAuthView()
        } else {
            if(locationAuth.isEnable) {
                ZStack {
                    Map(coordinateRegion: $locationAuth.region)
                        .edgesIgnoringSafeArea(.all)

                    Rectangle().frame(width: width, height: height, alignment: .center)
                        .foregroundColor(.gray)
                        .opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                    
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
