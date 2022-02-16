//
//  SetGpsView.swift
//  seminar
//
//  Created by しゅん on 2022/02/17.
//

import SwiftUI
import MapKit

struct SetGpsView: View {
    
    @Binding var present:Bool

    @Binding var showMain:Bool
    
    @ObservedObject var locationAuth = LocationAuth()
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    
    @State private var isSet = false
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 0.7490196078431373, green: 0.615686274509804, blue: 0.3686274509803922))
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: width - 20, height: nil, alignment: .center)
                    .foregroundColor(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9490196078431372))
                    .padding(.top)
                
                if(isSet) {
                    SetFlickAuth(present: $present, showMain: $showMain)
                } else {
                    if(locationAuth.isEnable) {
                        
                        
                        VStack {
                            Text("位置情報の登録")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding(.top)
                            
                            Spacer(minLength: 20.0)
                            Map(coordinateRegion: $locationAuth.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode)
                                .frame(width: width - 20, height: height*0.30)
                                //.border(Color.gray)
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .frame(width: width - 55, height: 50, alignment: .center)
                                    .foregroundColor(Color(red: 0.9294117647058824, green: 0.49019607843137253, blue: 0.19607843137254902))
                                
                                
                                Text("現在位置を登録する")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                                
                            }.onTapGesture(perform: {
                                isSet.toggle()
                            })
                            .padding(.vertical, 2.5)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .frame(width: width - 55, height: 50, alignment: .center)
                                    .foregroundColor(Color.gray)
                                
                                
                                Text("あとで")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                            }.padding(.bottom, 30.0)
                        }
                        
                    } else {
                        Text("これはダミーテキストです").foregroundColor(.white).onAppear() {
                            locationAuth.request()
                        }
                    }
                }
            }.frame(width: geometory.size.width,height: geometory.size.height)
                .animation(.linear(duration: 0.2))
        }.transition(.move(edge: .trailing))
    }
}

struct SetGpsView_Previews: PreviewProvider {
    @State static var present = true
    @State static var showMain = false
    static var previews: some View {
        SetGpsView(present: $present, showMain: $showMain)
    }
}
