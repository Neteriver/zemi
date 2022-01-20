//
//  FlickAuth.swift
//  seminar
//
//  Created by しゅん on 2021/12/29.
//

import SwiftUI
import AlertToast

struct FlickAuthView: View {
    
    // 辞書
    let dic = "すいかわりをしませんか"
    
    //入力文字
    @State var input = ""
    
    //フリック時間(タップ時間)
    @State var onTime = 0.0
    
    //フリック時間(間隔)
    @State var waitTime = 0.0
    
    //フリック距離
    @State var distance:CGFloat = 0
    
    //フリック角度
    @State var angle:CGFloat = 0
    
    //エンター
    @State var isEnter = false
    
    // x移動値
    @State var xDistance:Double = 0.0
    
    // y移動値
    @State var yDistance:Double = 0.0
    
    @ObservedObject var flickAuth = FlickAuth()
    
    var flickAuthData = FlickAuthData()
    
    let width = UIScreen.main.bounds.width
    
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        
        if(flickAuth.result) {
            TopView()
        } else {
            ZStack {
                VStack {
                    Spacer()
                    
                    Group {
                        Text("\(dic)")
                            .font(.title)
                            .padding(10)
                        
                        //                        Text("\(dic.value)")
                        //                            .font(.title2)
                        //                            .padding(30)
                        
                        Text("\(input)")
                        
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("onTime: \(onTime)")
                        Text("waitTime: \(waitTime)")
                        Text("angle: \(angle)")
                        Text("distance: \(distance)")
                    }
                    
                    Spacer()
                    
                    KeyboardView(input: $input,
                                 onTime: $onTime,
                                 waitTime: $waitTime,
                                 angle: $angle,
                                 distance: $distance,
                                 isEnter: $isEnter)
                }
                
                // Enterキーを押下したときの処理
                if(isEnter) {
                    
                    Rectangle().frame(width: width, height: height, alignment: .center)
                        .foregroundColor(.gray)
                        .opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                    
                    AlertToast(type: .loading, title: "フリック認証中です", subTitle: nil)
                        .alert("フリックが一致しません", isPresented: $flickAuth.isAuthingBad) {
                            Button("了解") {
                                flickAuth.auth()
                            }
                        } message: {
                            Text("フリックが一致しません")
                        }.onAppear(perform: {
                            flickAuth.auth()
                        })
                    
                }
            }
            
        }
        
        
        
    }
}

struct FlickAuthView_Previews: PreviewProvider {
    static var previews: some View {
        FlickAuthView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
