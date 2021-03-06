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
    
    // 初期設定フラグ
    @State var initFlag = false
    
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
    
    @ObservedObject var flickAuth = FlickAuth()
    
    @State var message = "登録するパスワードを入力してください"
    @State var countDown = ""
    
    
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
                        Text("\(message)")
                        Text("\(input)")
                            .font(.title)
                            .padding(10)
                    }
                    
                    Spacer()
                    
                    KeyboardView(input: $input,
                                 length: inputLength,
                                 onTime: $onTime,
                                 waitTime: $waitTime,
                                 xDistance: $xDistance,
                                 yDistance: $yDistance,
                                 isEnter: $isEnter,
                                 flickAuth: flickAuth)
                }
                
                // Enterキーを押下したときの処理
                if(isEnter) {
                    if(initFlag) {
                        //SetFlickAuth()
                    } else {
                        SetFlickAuth(count: count, initFlag: true, message: "データ登録のためあと\(count)回入力して下さい").onAppear {
                            self.count = count - 1
                        }
                    }
                }
            }
            
        }
    }
    
    fileprivate func afteredEnter (){
        
    }
    fileprivate func countMinus(num: Int) -> Int {
        return num - 1
    }
}


struct SetFlickAuth_Previews: PreviewProvider {
    static var previews: some View {
        SetFlickAuth()
    }
}
