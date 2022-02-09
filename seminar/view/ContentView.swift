//
//  ContentView.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/09.
//

import UIKit
import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State var message = "Fivate"
    @State var authResult:Bool = false
    @State var show = false
    @State var firstTime = true
    @State var flickFlag = false
    
    let faceAuth:FaceAuth = FaceAuth()
    let flickAuth = FlickAuth()
    
    var pass : String { get { return flickAuth.getPass() ?? "" } }
    
    
    var body: some View {
        if(pass == "") {
            // 初回起動時初期設定を行う
            SetFlickAuth()
        } else {
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
//        if(show) {
//            GpsView()
//        } else {
//            PasswordView { otp, completionHandler in
//                if(otp == "1111") {
//                    completionHandler(true)
//                    show = true
//                } else {
//                    completionHandler(false)
//                }
//            }
//        }
    }
    
    
    //    func exec() {
    //        // GPS認証
    //        locationAuth.auth { locationData in
    //            message = locationData.message
    //            authResult = locationData.result
    //
    //            if !authResult {
    //                return
    //            }
    //            // 顔認証
    //            faceAuth.auth { faceData in
    //                message = faceData.message
    //                authResult = faceData.result
    //
    //                if !authResult {
    //                    return
    //                }
    //            }
    //        }
    // パスワード認証？
    //        passwordAuth.setupPassword()
    //    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
