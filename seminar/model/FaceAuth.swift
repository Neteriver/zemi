//
//  FaceAuth.swift.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/09.
//

import Foundation
import LocalAuthentication

class FaceAuth {
    // 生体認証を管理クラスを生成
    var context: LAContext = LAContext()
    // 認証ポップアップに表示するメッセージ
    let reason = "パスワードを入力してください"

    // 顔認証処理
    func auth(complation:@escaping(FaceAuthData) -> Void) {
        let data = FaceAuthData()
        // 顔認証が利用できるかチェック
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            // 認証処理の実行
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                if success {
                    DispatchQueue.main.async {
                        data.message = "FaceID認証が成功しました"
                        data.result = true
                        complation(data)
                    }
                } else if let laError = error as? LAError {
                    switch laError.code {
                    case .authenticationFailed:
                        data.message = "認証に失敗しました"
                        data.result = false
                        complation(data)
                        break
                    case .userCancel:
                        data.message = "認証がキャンセルされました"
                        data.result = false
                        complation(data)
                        break
                    case .userFallback:
                        data.message = "認証に失敗しました"
                        data.result = false
                        complation(data)
                        break
                    case .systemCancel:
                        data.message = "認証が自動キャンセルされました"
                        data.result = false
                        complation(data)
                        break
                    case .passcodeNotSet:
                        data.message = "パスコードが入力されませんでした"
                        data.result = false
                        complation(data)
                        break
                    case .touchIDNotAvailable:
                        data.message = "指紋認証の失敗上限に達しました"
                        data.result = false
                        complation(data)
                        break
                    case .touchIDNotEnrolled:
                        data.message = "指紋認証が許可されていません"
                        data.result = false
                        complation(data)
                        break
                    case .touchIDLockout:
                        data.message = "指紋が登録されていません"
                        data.result = false
                        complation(data)
                        break
                    case .appCancel:
                        data.message = "アプリ側でキャンセルされました"
                        data.result = false
                        complation(data)
                        break
                    case .invalidContext:
                        data.message = "不明なエラー"
                        data.result = false
                        complation(data)
                        break
                    case .notInteractive:
                        data.message = "システムエラーが発生しました"
                        data.result = false
                        complation(data)
                        break
                    @unknown default:
                        // 何もしない
                        break
                    }
                }
            }
        } else {
            // 生体認証ができない場合の認証画面表示など
        }
    }
}
