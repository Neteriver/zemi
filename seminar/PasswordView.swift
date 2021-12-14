//
//  PasswordView.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/14.
//

import SwiftUI
import SmileLock
import Foundation

struct PasswordView : View{
    class PasswordAuth : PasswordInputCompleteProtocol{
        func validation(_ input:String) -> Bool{
            // パスワードの照合をおこなっている
            // 返り値はBoolean型
            // 現状は正解パスワードを直書きしている
            return input == "0000"
        }
        func validationSuccess(){
            // パスワードが正しかった時の処理
        }
        func validationFail(){
            // パスワードが間違っていた時の処理
            passwordContainerView.wrongPassword()
        }
        func passwordInputComplete(_ contentView: PasswordContainerView, input: String) {
            if validation(input) {
                validationSuccess()
            } else {
                validationFail()
            }
        }
        // 指紋認証のやつ
        func touchAuthenticationComplete(_ contentView: PasswordContainerView, success: Bool, error: Error?) {
            if success {
                self.validationSuccess()
            } else {
                contentView.clearInput()
            }
        }
        //パスワード画面を生成
        var passwordContainerView: PasswordContainerView!
        //パスワードの桁数
        let kPasswordDigit = 4
        
        func viewDidLoad() {
            //create PasswordContainerView
            passwordContainerView = PasswordContainerView.create(withDigit: kPasswordDigit)
            passwordContainerView.delegate = self
            passwordContainerView.deleteButtonLocalizedTitle = "削除"
        }
        
        func didReceiveMemoryWarning() {
            didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    var body: some View {
        Text("Hello, World!")
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}
