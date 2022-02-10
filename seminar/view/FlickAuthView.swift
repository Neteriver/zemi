//
//  FlickAuth.swift
//  seminar
//
//  Created by しゅん on 2021/12/29.
//

import SwiftUI
import AlertToast

struct FlickAuthView: View {
    
    // 認証用文字列
    let dic = "すいかわりをしませんか"
    
    // 認証用文字列の長さ
    var length : Int { get { return dic.count } }
    
    @State var authList:[[Double]] = []
    
    //入力文字
    @State var input = ""
    
    //フリック時間(タップ時間)
    @State var onTime = 0.0
    
    //フリック時間(間隔)
    @State var waitTime = 0.0
    
    //エンター
    @State var isEnter = false
    
    // x移動値
    @State var xDistance:Double = 0
    
    // y移動値
    @State var yDistance:Double = 0
    
    @State var message:String = ""
    @State var num:Int = 0
    @State var trans:Bool = false
    
    @State var isStandard = false
    
    @ObservedObject var flickAuth = FlickAuth()
    
    var flickPass : String { get { return flickAuth.getPass() ?? "" } }
    
    
    let width = UIScreen.main.bounds.width
    
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        
        if flickAuth.result && isStandard {
            TopView()
        } else {
            ZStack {
                VStack {
                    Spacer()
                    
                    Group {
                        Text("\(flickPass)")
                            .font(.title)
                            .padding(10)
                        
                        Text("\(input)")
                        
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("キーを押している時間: \(onTime)")
                        Text("次のキーを押すまでの時間: \(waitTime)")
                        Text("x移動値: \(xDistance)")
                        Text("y移動値: \(yDistance)")
                    }
                    
                    Spacer()
                    
                    KeyboardView(input: $input,
                                 length: length,
                                 authList: $authList,
                                 onTime: $onTime,
                                 waitTime: $waitTime,
                                 xDistance: $xDistance,
                                 yDistance: $yDistance,
                                 isEnter: $isEnter,
                                 flickAuth: flickAuth)
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
                                self.isEnter = false
                                self.input = ""
                                self.authList = flickAuth.removeArray()
                                self.onTime = 0
                                self.waitTime = 0
                                self.xDistance = 0
                                self.yDistance = 0
                            }
                        } message: {
                            Text("フリックが一致しません")
                        }.onAppear(perform: {
                            flickAuth.auth(dic: flickPass, input: input)
                            isStandard = flickAuth.authBase(length: input.count, authList: authList)
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
