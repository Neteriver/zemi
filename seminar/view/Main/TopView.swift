//
//  TopView.swift
//  seminar
//
//  Created by しゅん on 2022/01/10.
//

import SwiftUI

struct TopView: View {
    var body: some View {
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

        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
