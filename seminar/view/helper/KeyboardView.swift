//
//  KeyboardView.swift
//  seminar
//
//  Created by しゅん on 2021/12/29.
//

import SwiftUI

struct KeyboardView: View {
    // 入力文字
    @Binding var input:String
    
    // 設定したパスワードの文字数
    @State var length:Int
    
    @Binding var authList:[[Double]]
    
    // ドラッグ開始時間
    @State var onTapFlg = false
    @State var tapStartTime = Date()
    @Binding var onTime:Double
    
    // 間隔時間
    @State var intervalTime = Date()
    @Binding var waitTime:Double
    
    // 距離
    @Binding var xDistance:Double
    @Binding var yDistance:Double
    
    // 確定ボタン
    @Binding var isEnter:Bool
    
    let flickAuth:FlickAuth
    
    
    let radius = 4.0
    
    let rowTop = 3.0
    let rowLeft = 2.0
    let rowButtom = 3.0
    let rowRight = 2.0
    
    let top = 1.0
    let left = 0.0
    let buttom = 0.0
    let right = 0.0
    
    // 重ねり順フラグ
    @State var touchRow1 = false
    @State var touchRow2 = false
    @State var touchRow3 = false
    @State var touchRow4 = false
    @State var touchColomn1 = false
    @State var touchColomn2 = false
    @State var touchColomn3 = false
    
    // あ行
    @State var iflg = false
    @State var uflg = false
    @State var eflg = false
    @State var oflg = false
    
    // か行
    @State var kiflg = false
    @State var kuflg = false
    @State var keflg = false
    @State var koflg = false
    
    // さ行
    @State var siflg = false
    @State var suflg = false
    @State var seflg = false
    @State var soflg = false
    
    // た行
    @State var tiflg = false
    @State var tuflg = false
    @State var teflg = false
    @State var toflg = false
    
    // な行
    @State var niflg = false
    @State var nuflg = false
    @State var neflg = false
    @State var noflg = false
    
    // は行
    @State var hiflg = false
    @State var huflg = false
    @State var heflg = false
    @State var hoflg = false
    
    // ま行
    @State var miflg = false
    @State var muflg = false
    @State var meflg = false
    @State var moflg = false
    
    // や行
    @State var yuflg = false
    @State var yoflg = false
    
    // ら行
    @State var riflg = false
    @State var ruflg = false
    @State var reflg = false
    @State var roflg = false
    
    // わ行
    @State var woflg = false
    @State var nflg = false
    
    // 句読点
    @State var kutenflg = false
    @State var hatenaflg = false
    @State var bikkuriflg = false
    
    // 濁点
    let sonant = [
        "か":"が",
        "き":"ぎ",
        "く":"ぐ",
        "け":"げ",
        "こ":"ご",
        "さ":"っざ",
        "し":"じ",
        "す":"ず",
        "せ":"ぜ",
        "そ":"ぞ",
        "た":"だ",
        "ち":"ぢ",
        "つ":"っ",
        "て":"で",
        "と":"ど",
        "は":"ば",
        "ひ":"び",
        "ふ":"ぶ",
        "へ":"べ",
        "ほ":"ぼ",
        "ば":"ぱ",
        "び":"ぴ",
        "ぶ":"ぷ",
        "べ":"ぺ",
        "ぼ":"ぽ",
        "っ":"づ",
        "や":"ゃ",
        "ゆ":"ゅ",
        "よ":"ょ",
    ]
    
    var body: some View {
        
        
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 0.82, green: 0.835, blue: 0.859))
            
            HStack{
                VStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(Color(red: 0.671, green: 0.698, blue: 0.741))
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            Text("")
                                .font(.title2)
                                .fontWeight(.regular)
                        )
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(Color(red: 0.671, green: 0.698, blue: 0.741))
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            Text("")
                                .font(.title2)
                                .fontWeight(.regular)
                        )
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(Color(red: 0.914, green: 0.925, blue: 0.878))
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            Text("")
                                .font(.title3)
                                .fontWeight(.regular)
                        )
                    HStack {
                        RoundedRectangle(cornerRadius: radius)
                            .foregroundColor(Color(red: 0.671, green: 0.698, blue: 0.741))
                            .padding(EdgeInsets(top: top,
                                                leading: left,
                                                bottom: buttom,
                                                trailing: right))
                            .overlay(
                                Text("")
                                    .font(.title2)
                                    .fontWeight(.regular)
                            )
                        RoundedRectangle(cornerRadius: radius)
                            .foregroundColor(Color(red: 0.671, green: 0.698, blue: 0.741))
                            .padding(EdgeInsets(top: top,
                                                leading: left,
                                                bottom: buttom,
                                                trailing: right))
                            .overlay(
                                Text("")
                                    .font(.title2)
                                    .fontWeight(.regular)
                            )
                    }
                }
                .padding(EdgeInsets(top: rowTop,
                                    leading: rowLeft,
                                    bottom: rowButtom,
                                    trailing: rowRight))
                
                VStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("あ")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(iflg) {
                                    KeyboardButton(char: "い", vector: .left)
                                } else if(uflg) {
                                    KeyboardButton(char: "う", vector: .top)
                                    
                                } else if(eflg) {
                                    KeyboardButton(char: "え", vector: .right)
                                } else if(oflg) {
                                    KeyboardButton(char: "お", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "あ"
                            // 間隔時間を上書きする(タップジェスチャーは計測不可のため)
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysA(value)
                        })
                        ).zIndex(touchRow1 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("た")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(tiflg) {
                                    KeyboardButton(char: "ち", vector: .left)
                                } else if(tuflg) {
                                    KeyboardButton(char: "つ", vector: .top)
                                    
                                } else if(teflg) {
                                    KeyboardButton(char: "て", vector: .right)
                                } else if(toflg) {
                                    KeyboardButton(char: "と", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "た"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysTA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysTA(value)
                        })
                        ).zIndex(touchRow2 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("ま")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(miflg) {
                                    KeyboardButton(char: "み", vector: .left)
                                } else if(muflg) {
                                    KeyboardButton(char: "む", vector: .top)
                                    
                                } else if(meflg) {
                                    KeyboardButton(char: "め", vector: .right)
                                } else if(moflg) {
                                    KeyboardButton(char: "も", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "ま"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysMA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysMA(value)
                        })
                        ).zIndex(touchRow3 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            Text("゛")
                                .font(.title3)
                                .fontWeight(.regular)
                        ).onTapGesture {
                            let suffix = input.suffix(1)
                            if let c = sonant[String(suffix)] {
                                input = input.replacingOccurrences(of: ".$", with: c, options: .regularExpression)
                            }
                            intervalTime = Date()
                        }
                        .zIndex(touchRow4 ? 1 : 0)
                    
                }
                .padding(EdgeInsets(top: rowTop,
                                    leading: rowLeft,
                                    bottom: rowButtom,
                                    trailing: rowRight))
                .zIndex(touchColomn1 ? 1 : 0)
                
                VStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("か")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(kiflg) {
                                    KeyboardButton(char: "き", vector: .left)
                                } else if(kuflg) {
                                    KeyboardButton(char: "く", vector: .top)
                                    
                                } else if(keflg) {
                                    KeyboardButton(char: "け", vector: .right)
                                } else if(koflg) {
                                    KeyboardButton(char: "こ", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "か"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysKA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysKA(value)
                        })
                        ).zIndex(touchRow1 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("な")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(niflg) {
                                    KeyboardButton(char: "に", vector: .left)
                                } else if(nuflg) {
                                    KeyboardButton(char: "ぬ", vector: .top)
                                    
                                } else if(neflg) {
                                    KeyboardButton(char: "ね", vector: .right)
                                } else if(noflg) {
                                    KeyboardButton(char: "の", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "な"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysNA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysNA(value)
                        })
                        ).zIndex(touchRow2 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("や")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(yuflg) {
                                    KeyboardButton(char: "ゆ", vector: .top)
                                } else if(yoflg) {
                                    KeyboardButton(char: "よ", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "や"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysYA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysYA(value)
                        })
                        ).zIndex(touchRow3 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("わ")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(woflg) {
                                    KeyboardButton(char: "を", vector: .left)
                                } else if(nflg) {
                                    KeyboardButton(char: "ん", vector: .top)
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "わ"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysWA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysWA(value)
                        })
                        ).zIndex(touchRow4 ? 1 : 0)
                    
                }
                .padding(EdgeInsets(top: rowTop,
                                    leading: rowLeft,
                                    bottom: rowButtom,
                                    trailing: rowRight))
                .zIndex(touchColomn2 ? 1 : 0)
                
                VStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("さ")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(siflg) {
                                    KeyboardButton(char: "し", vector: .left)
                                } else if(suflg) {
                                    KeyboardButton(char: "す", vector: .top)
                                    
                                } else if(seflg) {
                                    KeyboardButton(char: "せ", vector: .right)
                                } else if(soflg) {
                                    KeyboardButton(char: "そ", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "さ"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysSA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysSA(value)
                        })
                        ).zIndex(touchRow1 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("は")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(hiflg) {
                                    KeyboardButton(char: "ひ", vector: .left)
                                } else if(huflg) {
                                    KeyboardButton(char: "ふ", vector: .top)
                                    
                                } else if(heflg) {
                                    KeyboardButton(char: "へ", vector: .right)
                                } else if(hoflg) {
                                    KeyboardButton(char: "ほ", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "は"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysHA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysHA(value)
                        })
                        ).zIndex(touchRow2 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("ら")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                
                                if(riflg) {
                                    KeyboardButton(char: "り", vector: .left)
                                } else if(ruflg) {
                                    KeyboardButton(char: "る", vector: .top)
                                    
                                } else if(reflg) {
                                    KeyboardButton(char: "れ", vector: .right)
                                } else if(roflg) {
                                    KeyboardButton(char: "ろ", vector: .down)
                                    
                                }
                            }.frame(width: 100, height: 100, alignment: .center
                                   )
                        ).onTapGesture {
                            input += "ら"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysRA(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysRA(value)
                        })
                        ).zIndex(touchRow3 ? 1 : 0)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            ZStack {
                                Text("、。?!")
                                    .font(.title2)
                                .fontWeight(.regular)
                                
                                if(kutenflg) {
                                    KeyboardButton(char: "。", vector: .left)
                                } else if(hatenaflg) {
                                    KeyboardButton(char: "？", vector: .top)
                                    
                                } else if(bikkuriflg) {
                                    KeyboardButton(char: "！", vector: .right)
                                }
                            }.frame(width: 100, height: 100, alignment: .center)
                        ).onTapGesture {
                            input += "、"
                            intervalTime = Date()
                        }
                        .gesture(DragGesture()
                                    .onChanged({ value in
                            flickingKeysKutoten(value)
                            
                        })
                                    .onEnded({ value in
                            flickedKeysKutoten(value)
                        })).zIndex(touchRow4 ? 1 : 0)
                    
                }
                .padding(EdgeInsets(top: rowTop,
                                    leading: rowLeft,
                                    bottom: rowButtom,
                                    trailing: rowRight))
                .zIndex(touchColomn3 ? 1 : 0)
                
                VStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(Color(red: 0.671, green: 0.698, blue: 0.741))
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            Text("←")
                                .font(.title2)
                                .fontWeight(.regular)
                                .onTapGesture(perform: {
                                    input = ""
                                    self.authList = flickAuth.removeArray()
                                    self.waitTime = 0
                                    self.onTime = 0
                                    self.yDistance = 0
                                    self.xDistance = 0
                                    intervalTime = Date()
                                })
                        )
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(Color(red: 0.671, green: 0.698, blue: 0.741))
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .overlay(
                            Text("")
                                .font(.title2)
                                .fontWeight(.regular)
                        )
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.blue)
                        .padding(EdgeInsets(top: top,
                                            leading: left,
                                            bottom: buttom,
                                            trailing: right))
                        .frame(width: .none, height: 113, alignment: .center)
                        .overlay(
                            Text("確定")
                                .font(.title2)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                        ).onTapGesture {
                            // 認証
                            isEnter.toggle()
                        }
                    
                }
                .padding(EdgeInsets(top: rowTop,
                                    leading: rowLeft,
                                    bottom: rowButtom,
                                    trailing: rowRight))
            }
            
        }.frame(width: .infinity, height: 240.0, alignment: .center)
            .onAppear(perform: {
                // 時間計測を開始
                intervalTime = Date()
            })
    }
    
    
    fileprivate func flickingKeysA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            iflg = false
            uflg = false
            eflg = false
            oflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow1 = true
        touchColomn1 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            uflg = false
            oflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                iflg = true
                eflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                iflg = false
                eflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            iflg = false
            eflg = false
            if (value.translation.height < 0 ) {
                // 上
                uflg = true
                oflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                uflg = false
                oflg = true
            }
        }
        

        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            iflg = false
            uflg = false
            eflg = false
            oflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "い"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "え"
            }
        } else {
            // 左右より上下の方が大きい場合
            iflg = false
            uflg = false
            eflg = false
            oflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "う"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "お"
            }
        }
        
        
        // 重なり順を解除
        touchRow1 = false
        touchColomn1 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        print("??:\(authList)")
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    
    fileprivate func flickingKeysKA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            kiflg = false
            kuflg = false
            keflg = false
            koflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow1 = true
        touchColomn2 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            kuflg = false
            koflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                kiflg = true
                keflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                kiflg = false
                keflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            kiflg = false
            keflg = false
            if (value.translation.height < 0 ) {
                // 上
                kuflg = true
                koflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                kuflg = false
                koflg = true
            }
        }
        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))

        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysKA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            kiflg = false
            kuflg = false
            keflg = false
            koflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "き"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "け"
            }
        } else {
            // 左右より上下の方が大きい場合
            kiflg = false
            kuflg = false
            keflg = false
            koflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "く"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "こ"
            }
        }
        // 重なり順を解除
        touchRow1 = false
        touchColomn2 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        
        intervalTime = Date()
    }
    
    fileprivate func flickingKeysSA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            siflg = false
            suflg = false
            seflg = false
            soflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow1 = true
        touchColomn3 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            suflg = false
            soflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                siflg = true
                seflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                siflg = false
                seflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            siflg = false
            seflg = false
            if (value.translation.height < 0 ) {
                // 上
                suflg = true
                soflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                suflg = false
                soflg = true
            }
        }

        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysSA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            siflg = false
            suflg = false
            seflg = false
            soflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "し"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "せ"
            }
        } else {
            // 左右より上下の方が大きい場合
            siflg = false
            suflg = false
            seflg = false
            soflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "す"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "そ"
            }
        }
        // 重なり順を解除
        touchRow1 = false
        touchColomn3 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    
    fileprivate func flickingKeysTA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            tiflg = false
            tuflg = false
            teflg = false
            toflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow2 = true
        touchColomn1 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            tuflg = false
            toflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                tiflg = true
                teflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                tiflg = false
                teflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            tiflg = false
            teflg = false
            if (value.translation.height < 0 ) {
                // 上
                tuflg = true
                toflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                tuflg = false
                toflg = true
            }
        }
        
        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))

        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysTA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            tiflg = false
            tuflg = false
            teflg = false
            toflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "ち"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "て"
            }
        } else {
            // 左右より上下の方が大きい場合
            tiflg = false
            tuflg = false
            teflg = false
            toflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "つ"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "と"
            }
        }
        // 重なり順を解除
        touchRow2 = false
        touchColomn1 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    fileprivate func flickingKeysNA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            niflg = false
            nuflg = false
            neflg = false
            noflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow2 = true
        touchColomn2 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            nuflg = false
            noflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                niflg = true
                neflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                niflg = false
                neflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            niflg = false
            neflg = false
            if (value.translation.height < 0 ) {
                // 上
                nuflg = true
                noflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                nuflg = false
                noflg = true
            }
        }

        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysNA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            niflg = false
            nuflg = false
            neflg = false
            noflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "に"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "ね"
            }
        } else {
            // 左右より上下の方が大きい場合
            niflg = false
            nuflg = false
            neflg = false
            noflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "ぬ"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "の"
            }
        }
        // 重なり順を解除
        touchRow2 = false
        touchColomn2 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    fileprivate func flickingKeysHA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            hiflg = false
            huflg = false
            heflg = false
            hoflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow2 = true
        touchColomn3 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            huflg = false
            hoflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                hiflg = true
                heflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                hiflg = false
                heflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            hiflg = false
            heflg = false
            if (value.translation.height < 0 ) {
                // 上
                huflg = true
                hoflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                huflg = false
                hoflg = true
            }
        }

        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysHA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            hiflg = false
            huflg = false
            heflg = false
            hoflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "ひ"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "へ"
            }
        } else {
            // 左右より上下の方が大きい場合
            hiflg = false
            huflg = false
            heflg = false
            hoflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "ふ"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "ほ"
            }
        }
        // 重なり順を解除
        touchRow2 = false
        touchColomn3 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    fileprivate func flickingKeysMA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            miflg = false
            muflg = false
            meflg = false
            moflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow1 = true
        touchColomn3 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            muflg = false
            moflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                miflg = true
                meflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                miflg = false
                meflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            miflg = false
            meflg = false
            if (value.translation.height < 0 ) {
                // 上
                muflg = true
                moflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                muflg = false
                moflg = true
            }
        }

        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysMA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            miflg = false
            muflg = false
            meflg = false
            moflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "み"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "め"
            }
        } else {
            // 左右より上下の方が大きい場合
            miflg = false
            muflg = false
            meflg = false
            moflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "む"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "も"
            }
        }
        // 重なり順を解除
        touchRow1 = false
        touchColomn3 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    fileprivate func flickingKeysYA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            yuflg = false
            yoflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow3 = true
        touchColomn2 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            yuflg = false
            yoflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                //yiflg = true
                //yeflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                //yiflg = false
                //yeflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            //yiflg = false
            //yeflg = false
            if (value.translation.height < 0 ) {
                // 上
                yuflg = true
                yoflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                yuflg = false
                yoflg = true
            }
        }

        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysYA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            yuflg = false
            yoflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                //input += "い"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                //input += "え"
            }
        } else {
            // 左右より上下の方が大きい場合
            yuflg = false
            yoflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "ゆ"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "よ"
            }
        }
        // 重なり順を解除
        touchRow2 = false
        touchColomn3 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    
    fileprivate func flickingKeysRA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            riflg = false
            ruflg = false
            reflg = false
            roflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow3 = true
        touchColomn3 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            ruflg = false
            roflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                riflg = true
                reflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                riflg = false
                reflg = true
            }
        } else {
            // 左右より上下の方が大きい場合
            riflg = false
            reflg = false
            if (value.translation.height < 0 ) {
                // 上
                ruflg = true
                roflg = false
            } else if (value.translation.height > 0 ) {
                // 下
                ruflg = false
                roflg = true
            }
        }
        
        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysRA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            riflg = false
            ruflg = false
            reflg = false
            roflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "り"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "れ"
            }
        } else {
            // 左右より上下の方が大きい場合
            riflg = false
            ruflg = false
            reflg = false
            roflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "る"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                input += "ろ"
            }
        }
        // 重なり順を解除
        touchRow3 = false
        touchColomn3 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    fileprivate func flickingKeysWA(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            woflg = false
            nflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow4 = true
        touchColomn2 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            woflg = false
            nflg = false
            // 上下より左右の移動が大きい場合
            if (value.translation.width < 0 ) {
                // 左
                woflg = true
            } else if (value.translation.width > 0 ) {
                // 右
                // なにもしない
            }
        } else {
            // 左右より上下の方が大きい場合
            woflg = false
            if (value.translation.height < 0 ) {
                // 上
                nflg = true
            } else if (value.translation.height > 0 ) {
                // 下
                // なにもしない
            }
        }
        
        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysWA(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            woflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "を"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                // なにもしない
            }
        } else {
            // 左右より上下の方が大きい場合
            nflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "ん"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                //なにもしない
            }
        }
        // 重なり順を解除
        touchRow4 = false
        touchColomn2 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
    
    fileprivate func flickingKeysKutoten(_ value: DragGesture.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            kutenflg = false
            hatenaflg = false
            bikkuriflg = false
            return
        }
        // Viewの重なりを最上へ
        touchRow4 = true
        touchColomn3 = true
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            hatenaflg = false
            if (value.translation.width < 0 ) {
                // 左
                kutenflg = true
                bikkuriflg = false
            } else if (value.translation.width > 0 ) {
                // 右
                bikkuriflg = true
                kutenflg = false
            }
        } else {
            // 左右より上下の方が大きい場合
            kuflg = false
            bikkuriflg = false
            if (value.translation.height < 0 ) {
                // 上
                hatenaflg = true
            } else if (value.translation.height > 0 ) {
                // 下
                // なにもしない
            }
        }
        
        // x移動値取得
        self.xDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.x,
                                                          to: value.location.x))
        // y移動値取得
        self.yDistance = Double(flickAuth.CGPointDistance(from: value.startLocation.y,
                                                          to: value.location.y))
        
        if(!onTapFlg) {
            // タップ状態へ
            self.onTapFlg = true
            // 間隔時間を取得
            self.waitTime = Date().timeIntervalSince(intervalTime)
            // タップ開始時間を取得
            self.tapStartTime = Date()
        }
    }
    
    fileprivate func flickedKeysKutoten(_ value: _ChangedGesture<DragGesture>.Value) {
        if (abs(value.translation.width) < 30 && abs(value.translation.height) < 30) {
            // 動きが小さすぎるため無視
            return
        }
        
        if(abs(value.translation.width) > abs(value.translation.height)) {
            // 上下より左右の移動が大きい場合
            kutenflg = false
            hatenaflg = false
            bikkuriflg = false
            if (value.translation.width < 0 ) {
                // swiped to left
                input += "。"
            } else if (value.translation.width > 0 ) {
                // swiped to right
                input += "！"
            }
        } else {
            // 左右より上下の方が大きい場合
            kutenflg = false
            hatenaflg = false
            bikkuriflg = false
            if (value.translation.height < 0 ) {
                // swiped to up
                input += "？"
            } else if (value.translation.height > 0 ) {
                // swiped to down
                //なにもしない
            }
        }
        // 重なり順を解除
        touchRow4 = false
        touchColomn3 = false
        
        onTapFlg = false
        onTime = Date().timeIntervalSince(tapStartTime)
        self.authList = flickAuth.StoreArray(index: flickAuth.LengthCount(input: input),
                             onTime: onTime,
                             waitTime: waitTime,
                             x: xDistance,
                             y: yDistance)
        intervalTime = Date()
    }
}

//struct KeyboardView_Previews: PreviewProvider {
//    
//    @State static var input = ""
//    @State static var onTime = 0.0
//    @State static var waitTime = 0.0
//    @State static var angle:CGFloat = 0
//    @State static var distance:CGFloat = 0
//    @State static var isEnter = false
//    
//    static var previews: some View {
//        KeyboardView(input: $input, onTime:$onTime, waitTime: $waitTime, angle:$angle, distance: $distance, isEnter: $isEnter)
//    }
//}
