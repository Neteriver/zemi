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
    
    
    @ObservedObject var flickAuth = FlickAuth()
    
    
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("パスコード")
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
                            title: "パスコードを入力",
                            message: "パスコードを入力してください",
                            leftButtonTitle: "キャンセル",
                            rightButtonTitle: "登録",
                            leftButtonAction: nil,
                            rightButtonAction: {
                                print("パスコード認証リクエスト")
                            }
                        )
                        HStack {
                            Text("パスコードの変更")
                            Spacer()
                            Image(systemName: "chevron.right").foregroundColor(.gray)
                        }.onTapGesture(perform: {
                            isShowingAlert.toggle()
                        })
                    }
                }
            } header :{
                Text("パスコード認証")
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
                    
                    NavigationLink(destination: SetFlickAuth(),
                                   label: {
                        Text("フリック文字の変更")
                        Spacer()
                    })
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

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
