//
//  GpsView.swift
//  seminar
//
//  Created by しゅん on 2021/12/16.
//

import SwiftUI

struct GpsView: View {
    
    @State var result = false
    let locationAuth:LocationAuth = LocationAuth()
    
    var body: some View {
        if(result) {
            Text("GPS認証画面").onAppear(perform: {
                // GPS認証
                // TODO (GPS認証しているような画面にする)
                locationAuth.auth { locationAuthData in
                    print(locationAuthData.message)
                    result = locationAuth.result
                }
            })
        } else {
            FlickAuthView()
        }
    }
}

struct GpsView_Previews: PreviewProvider {
    static var previews: some View {
        GpsView()
    }
}
