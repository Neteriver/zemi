//
//  MainData.swift
//  seminar
//
//  Created by しゅん on 2022/01/11.
//

import Foundation
import UIKit

struct MainData:Identifiable {
    var id:UUID
    var name:String
    var url:URL
    var isImage:Bool
    var size:String
    var insertDate:Date
}
