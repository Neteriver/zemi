//
//  ContentView.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/09.
//

import SmileLock
import UIKit
import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State var message = "AuthenticationApp"
    @State var authResult:Bool = false
    @State var pass = ""
    @State var show = false
    
    let faceAuth:FaceAuth = FaceAuth()
    let locationAuth:LocationAuth = LocationAuth()
    let flickAuth:FlickAuth = FlickAuth()
    
    var test = [1.0,2.0,4.0,9.0]
    
    
    var body: some View {
        FlickView()
        if(show) {
            GpsView()
        } else {
            PasswordView { otp, completionHandler in
                if(otp == "1111") {
                    completionHandler(true)
                    show = true
                } else {
                    completionHandler(false)
                }
            }
        }
    }
    func exec() {
        
        // GPS認証
        locationAuth.auth { locationData in
            message = locationData.message
            authResult = locationData.result
            
            if !authResult {
                return
            }
            // 顔認証
            faceAuth.auth { faceData in
                message = faceData.message
                authResult = faceData.result
                
                if !authResult {
                    return
                }
            }
        }
    }
    func develop (){
        flickAuth.develop()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
