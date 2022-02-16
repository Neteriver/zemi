//
//  InitSettingView.swift
//  seminar
//
//  Created by しゅん on 2022/02/16.
//

import SwiftUI

struct InitSettingView: View {
    
    @State private var present = false
    
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 0.7490196078431373, green: 0.615686274509804, blue: 0.3686274509803922))
            .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: width - 20, height: nil, alignment: .center)
                .foregroundColor(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9490196078431372))
            
            VStack {
                Spacer()
                
                Image("app")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.2))
                    .padding()
                
                Text("はじめまして")
                    .font(.title)
                    .fontWeight(.regular)
                    .padding(.vertical, 0.5)
                Text("ファイベートと申します")
                    .font(.title)
                    .fontWeight(.regular)
                    .padding(.bottom, 10.0)
                
                Spacer()
                
                Text("このアプリは、大事なデータを誰にも見せることなく、完全に管理できます。通常のファイルアプリよりもっとセキュアに、あなたを守ります。")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .lineSpacing(10)
                    .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .frame(width: width - 55, height: 50, alignment: .center)
                        .foregroundColor(Color(red: 0.9294117647058824, green: 0.49019607843137253, blue: 0.19607843137254902))
                    
                    
                    Text("登録を開始する")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                    
                }.onTapGesture(perform: {
                    present.toggle()
                }).sheet(isPresented: $present) {
                    SetFlickAuth()
                }
                .padding(.vertical, 2.5)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .frame(width: width - 55, height: 50, alignment: .center)
                        .foregroundColor(Color.gray)
                    
                    
                    Text("認証なしで進める")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                }.padding(.bottom, 30.0)
            }
        }
    }
}

struct InitSettingView_Previews: PreviewProvider {
    static var previews: some View {
        InitSettingView()
    }
}
