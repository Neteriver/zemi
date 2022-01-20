//
//  AuthData.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/14.
//
import SwiftUI
import Foundation
import ImageViewer
import MobileCoreServices

class LocationAuthData:ObservableObject {
    @Published var isEnable = false
    @Published var message:String = ""
    @Published var result:Bool = false
}

class FaceAuthData {
    var message:String = ""
    
    var result:Bool = false
}

class FlickAuthData {
    // x移動値データを格納する
    var xDis = [[Double]]()
    // y移動値のデータを格納する
    var yDis = [[Double]]()
    // タップ時間のデータを格納する
    var on = [[Double]]()
    // フリックの間隔のデータを格納する
    var wait = [[Double]]()
    
    
    // 認証用のデータを格納する
    var authInfo = [[Double]]()
}
