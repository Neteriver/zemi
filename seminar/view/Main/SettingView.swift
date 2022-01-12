//
//  SettingView.swift
//  seminar
//
//  Created by しゅん on 2022/01/12.
//

import SwiftUI

struct SettingView: View {
    @State var isPasswordOn = true
    @State var isGpsOn = true
    @State var isFlickOn = true
    
    @State private var isShowingAlert = false
    @State var text: String = ""
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("パスワード")
                    Spacer()
                    Toggle(isOn: $isPasswordOn.animation()) {
                        EmptyView()
                    }
                }
                
                if(isPasswordOn) {
                    ZStack {
                        TextFieldAlertView(
                            text: $text,
                            isShowingAlert: $isShowingAlert,
                            placeholder: "",
                            isSecureTextEntry: true,
                            title: "パスワードを入力",
                            message: "パスワードを入力してください",
                            leftButtonTitle: "キャンセル",
                            rightButtonTitle: "登録",
                            leftButtonAction: nil,
                            rightButtonAction: {
                                print("パスワード認証リクエスト")
                            }
                        )
                        HStack {
                            Text("パスフレーズ")
                            Spacer()
                            Image(systemName: "chevron.right").foregroundColor(.gray)
                        }.onTapGesture(perform: {
                            isShowingAlert.toggle()
                        })
                    }
                }
            } header :{
                Text("パスワード")
            }
            Section {
                HStack {
                    Text("GPS認証")
                    Spacer()
                    Toggle(isOn: $isGpsOn.animation()) {
                        EmptyView()
                    }
                }
                if(isGpsOn) {
                    HStack {
                        Text("位置情報の更新")
                        Spacer()
                        Image(systemName: "chevron.right").foregroundColor(.gray)
                    }
                }
            } header :{
                Text("GPS認証")
            }
            Section {
                HStack {
                    Text("フリック認証")
                    Spacer()
                    Toggle(isOn: $isFlickOn.animation()) {
                        EmptyView()
                    }
                }
                if(isFlickOn) {
                    
                    HStack {
                        Text("キーボード")
                        Spacer()
                        Image(systemName: "chevron.right").foregroundColor(.gray)
                    }
                }
            } header :{
                Text("フリック認証")
            }
            
            Section {
                HStack {
                    Text("アプリ内ストレージ")
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(.gray)
                }
            } header :{
                Text("情報")
            }
        }.navigationTitle("設定")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
