//
//  GpsView.swift
//  seminar
//
//  Created by しゅん on 2021/12/16.
//

import SwiftUI
import LocalAuthentication


struct GpsView: View {
    @State var message = "GPS認証画面"
    @State var authResult:Bool = false
    
    let locationAuth:LocationAuth = LocationAuth()
    
    var body: some View {
        Text("\(message)").onAppear{
            exec()
        }
    }
    func exec() {
        locationAuth.auth { locationData in
            message = locationData.message
            authResult = locationData.result
            
            if !authResult {
                return
            }
        }
    }
}

struct GpsView_Previews: PreviewProvider {
    static var previews: some View {
        GpsView()
    }
}
