//
//  FlickAuth.swift
//  seminar
//
//  Created by しゅん on 2022/01/11.
//

import Foundation
import SwiftUI
class FlickAuth:ObservableObject {
    
    @Published var isAuthingBad = false
    
    @Published var result = false
    
    
    func auth() {
        //　認証処理を書く。。
        result = true
    }
}
