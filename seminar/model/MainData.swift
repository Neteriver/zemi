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
    var image:UIImage
    var isImage:Bool
    var size:Double
    var insertDate:Date
}
