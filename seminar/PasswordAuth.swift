//
//  PasswordAuth.swift.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/09.
//

import Foundation
import SmileLock

class PasswordAuth {
    let contentView = PasswordContainerView.create(withDigit: 4)
    
    func setupPassword() {
        let contentView = PasswordContainerView.create(withDigit: 4)
        contentView.delegate = self
        contentView.deleteButtonLocalizedTitle = "削除"
    }
    //    func passwordInputComplete(_ contentView: PasswordContainerView, input: String) {
    //        if validation(input) {
    //            validationSuccess()
    //        } else {
    //            validationFail()
    //        }
    //    }
    //
    //    func touchAuthenticationComplete(_ contentView: PasswordContainerView, success: Bool, error: Error?) {
    //        if success {
    //            self.validationSuccess()
    //        } else {
    //            contentView.clearInput()
    //        }
    //    }
}
extension PasswordAuth : PasswordInputCompleteProtocol{
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
}
private extension PasswordAuth{
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
        contentView.wrongPassword()
    }
}
