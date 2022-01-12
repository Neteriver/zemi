//
//  Util.swift
//  seminar
//
//  Created by しゅん on 2022/01/12.
//

import Foundation
class Util {
    static func formatSize(size:UInt64) -> String {
        let format = String.localizedStringWithFormat("%d", size).reversed()
        var cnt = 0
        var index = 0
        var result = ""
        format.forEach({ char in
            if(cnt >= 1) {
                result = String(result.dropLast())
            }
            
            if(char == ",") {
                cnt = cnt + 1
                result.insert(".", at: result.startIndex)
            } else {
                result.insert(char, at: result.startIndex)
            }
            
            index = index + 1
        })

        if(cnt == 0) {
            result += " Byte"
        } else if(cnt == 1) {
            result += " KB"
        } else if(cnt == 2) {
            result += " MB"
        } else if(cnt == 3) {
            result += " GB"
        }
        return result
    }
}
