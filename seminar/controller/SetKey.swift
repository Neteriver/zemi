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
    
    func savePass(value: String, key: String) {
        keychain.set(value, key: key)
    }
}
