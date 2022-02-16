//
//  SetFlickAuth.swift
//  seminar
//
//  Created by 石井快思 on 2022/01/20.
//

// フリック認証のパスフレーズを設定する画面

import SwiftUI
import AlertToast

struct SetFlickAuth: View {
    
    // データ登録回数
    @State var count = 10
    //入力文字
    @State var input = ""
    // 認証用文字列の長さ
    var inputLength : Int { get { return input.count } }
    // 入力文字の退避用
    var inputTemp = ""
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
    
    @State var transition = false
    
    @State var initFlag = false
    
    @EnvironmentObject var flickAuth:FlickAuth
    
    @State var message = "新しいパスワードを入力してください"
    
    @State var countDown = ""
    
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        
        if(transition) {
            MainView()
        } else {
            
            GeometryReader { geometory in
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.7490196078431373, green: 0.615686274509804, blue: 0.3686274509803922))
                        .ignoresSafeArea()
                    
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: width - 20, height: nil, alignment: .center)
                        .foregroundColor(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9490196078431372))
                        .padding(.top)
                    
                    VStack {
                        Spacer()
                        Rectangle()
                            .frame(width: nil, height: 100, alignment: .center)
                            .foregroundColor(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9490196078431372))
                        
                    }.ignoresSafeArea()
                    
                    
                    VStack {
                        Text("フリック文字の登録")
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.top, 25.0)
                        
                        
                        Spacer()
                        
                        Group {
                            Text("\(message)")
                                .font(.title3)
                                .fontWeight(.regular)
                            Text("\(input)")
                                .font(.title)
                                .padding(10)
                        }
                        
                        Spacer()
                        
                        SetKeyboardView(input: $input,
                                        length: inputLength,
                                        onTime: $onTime,
                                        waitTime: $waitTime,
                                        xDistance: $xDistance,
                                        yDistance: $yDistance,
                                        isEnter: $isEnter,
                                        message: $message,
                                        num: $count,
                                        trans: $transition,
                                        initFlag: $initFlag,
                                        flickAuth: flickAuth).onAppear(perform: {
                            if(!initFlag) {
                                print("配列初期化")
                                flickAuth.initAll()
                            }
                        })
                    }
                    
                }.frame(width: geometory.size.width,height: geometory.size.height)
                    .animation(.linear(duration: 0.2))
            }.transition(.move(edge: .trailing))
            
        }
    }
}


struct SetFlickAuth_Previews: PreviewProvider {
    static var previews: some View {
        SetFlickAuth().environmentObject(FlickAuth())
    }
}
