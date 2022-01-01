//
//  FlickAuth.swift
//  seminar
//
//  Created by しゅん on 2021/12/29.
//

import SwiftUI

struct FlickAuthView: View {
    
    let title = ["スイカ割りをしませんか","焦らない焦らない","微笑みの貴公子","犬をもふもふしてみる"]
    let titleDetail = ["すいかわりをしませんか","あせらないあせらない","ほほえみのきこうし","いぬをもふもふしてみる"]
    let random = Int.random(in: 1..<4)
    
    @State var input = ""
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(title[random])")
                .font(.title)
                .padding(10)
            
            Text("\(titleDetail[random])")
                .font(.title2)
                .padding(30)
            
            Text("\(input)")
            
            Spacer()
            
            KeyboardView(input: $input)
        }
    }
    
}

struct FlickAuthView_Previews: PreviewProvider {
    static var previews: some View {
        FlickAuthView()
    }
}
