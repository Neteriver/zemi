//
//  AuthData.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/14.
//

import Foundation
class LocationAuthData:ObservableObject {
    @Published var isEnable = false
    @Published var message:String = ""
    @Published var result:Bool = false
}

class FaceAuthData {
    var message:String = ""
    
    var result:Bool = false
}
