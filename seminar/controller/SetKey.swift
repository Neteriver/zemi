//
//  SetKey.swift
//  seminar
//
//  Created by 石井快思 on 2022/02/07.
//

import Foundation
import KeychainAccess

class KeyChain {
    let keychain = Keychain(service: "AuthPass")
    
    // 保存
    func savePass(value: String, key: String) {
        try! keychain.set(value, key: key)
    }
    
    // 取得
    func getPass(key: String) -> String? {
        let data = try! keychain.get(key)
        print("data:\(data ?? "data is nil")")
        return data
    }
}
