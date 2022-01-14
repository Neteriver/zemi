//
//  TopView.swift
//  seminar
//
//  Created by しゅん on 2022/01/10.
//

import SwiftUI

struct TopView: View {
    
    @State var showLock = false
    
    var body: some View {
        if(showLock) {
            ContentView()
        } else {
            NavigationView {
                List {
                    Section() {
                        NavigationLink(destination: MainView(), label: {
                            TopRow(title: "ファイル", imageName: "house.circle")
                        })
                        TopRow(title: "お気に入り", imageName: "bookmark.circle")
                        TopRow(title: "共有", imageName: "square.and.arrow.up.circle")
                    }
                    Section() {
                        NavigationLink(destination: SettingView(), label: {
                            TopRow(title: "設定", imageName: "gear.circle.fill")
                        })
                        TopRow(title: "このアプリについて", imageName: "questionmark.circle.fill")
                    }
                }.navigationBarTitle("アプリ名")
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                        showLock = true
                    }
                
            }
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
