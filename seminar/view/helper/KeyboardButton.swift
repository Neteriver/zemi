//
//  KeyboardButton.swift
//  seminar
//
//  Created by しゅん on 2021/12/29.
//

import SwiftUI

struct KeyboardButton: View {
    
    let char:String
    let vector:Vector
    
    private var xpoint:Double {
        getXPoint()
    }
    private var ypoint:Double {
        getYPoint()
    }
    
    let width = CGFloat(240/4)
    let height = CGFloat(240/4)
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .stroke(Color.black, lineWidth: 0.3)
            .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.white))
            .frame(width: width, height: height, alignment: .leading)
            .offset(x: xpoint, y: ypoint)
            .overlay {
                Text("\(char)")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .offset(x: xpoint, y: ypoint)
                    .zIndex(3)
            }.zIndex(2)
    }
    
    enum Vector {
        case top
        case right
        case down
        case left
    }
    
    func getXPoint() -> Double {
        switch vector {
        case .top:
            return 0.0
        case.right:
            return 60.0
        case.down:
            return 0.0
        case .left:
            return -60.0
        }
    }
    
    func getYPoint() -> Double {
        switch vector {
        case.top:
            return -60.0
        case .right:
            return 0.0
        case .down:
            return 60.0
        case .left:
            return 0.0
        }
    }
}

//struct KeyboardButton_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyboardButton(char: "う", vector: KeyboardButton.Vector.top)
//    }
//}
