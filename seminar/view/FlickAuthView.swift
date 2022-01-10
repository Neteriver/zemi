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
    
    //フリック時間(タップ時間)
    @State var onTime = 0.0
    
    //フリック時間(間隔)
    @State var waitTime = 0.0
    
    //フリック距離
    @State var distance:CGFloat = 0
    
    //フリック角度
    @State var angle:CGFloat = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Group {
                Text("\(title[random])")
                    .font(.title)
                    .padding(10)
                
                Text("\(titleDetail[random])")
                    .font(.title2)
                    .padding(30)
                
                Text("\(input)")
                
            }
            Spacer()
            Text("onTime: \(onTime)")
            Text("waitTime: \(waitTime)")
            Text("angle: \(angle)")
            Text("distance: \(distance)")
            Spacer()
            
            KeyboardView(input: $input,
                         onTime: $onTime,
                         waitTime: $waitTime,
                         angle: $angle,
                         distance: $distance)
        }
    }
    
}

struct FlickAuthView_Previews: PreviewProvider {
    static var previews: some View {
        FlickAuthView()
    }
}
