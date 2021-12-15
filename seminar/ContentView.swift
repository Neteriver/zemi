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
    
    let faceAuth:FaceAuth = FaceAuth()
    let locationAuth:LocationAuth = LocationAuth()
    let passwordAuth:PasswordLoginController = PasswordLoginController()
    
    var body: some View {
        PasswordView { otp, completionHandler in
            // check if the otp is correct here
            print(otp)
        }
        
        Text("\(message)")
            .padding()
            .onAppear {
                //                PasswordView { otp, completionHandler in
                //                    // check if the otp is correct here
                //                    print(otp)
                //                }
                // 認証の実行
                //exec()
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
        // パスワード認証？
        //        passwordAuth.setupPassword()
    }
}
class PasswordLoginController {
    //パスワード画面を生成
    var passwordContainerView: PasswordContainerView!
    //パスワードの桁数
    let kPasswordDigit = 4
}

extension PasswordLoginController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if validation(input) {
            validationSuccess()
        } else {
            validationFail()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}

private extension PasswordLoginController{
    
    func validation(_ input:String) -> Bool{
        // ここでパスワードの照合を行う。
        return input == "1111"
    }
    
    func validationSuccess(){
        // パスワードが正しかった時の処理
    }
    
    func validationFail(){
        // パスワードが間違っていた時の処理（画面がブルブルっと震える）
        passwordContainerView.wrongPassword()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
