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
        GeometryReader { geometory in
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 0.7490196078431373, green: 0.615686274509804, blue: 0.3686274509803922))
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: width - 20, height: nil, alignment: .center)
                    .foregroundColor(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9490196078431372))
                    .padding(.top)
                
                
                if(locationAuth.result) {
                    FlickAuthView()
                } else {
                    if(locationAuth.isEnable) {
                        ZStack {
                            
                            VStack {
                                Spacer(minLength: 20.0)
                                Map(coordinateRegion: $locationAuth.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode)
                                    .frame(width: width - 20, height: height*0.30)
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
                        Text("").onAppear() {
                            locationAuth.request()
                        }
                    }
                }
                
            }.frame(width: geometory.size.width,height: geometory.size.height)
                .animation(.linear(duration: 0.2))
        }.transition(.move(edge: .trailing))
    }
}

struct GpsView_Previews: PreviewProvider {
    static var previews: some View {
        GpsView()
    }
}
