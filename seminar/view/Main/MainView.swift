//
//  MainView.swift
//  seminar
//
//  Created by しゅん on 2022/01/10.
//

import SwiftUI
import ImageViewer

struct MainView: View {
    
    // イメージ出力用
    @State var showImageViewer: Bool = false
    @State var image = Image("example-image")
    
    let mainData:[MainData] = [
        MainData(id: UUID(), name: "jpeg", image: UIImage(imageLiteralResourceName: "jpeg"), isImage: true, size: 0.01, insertDate: Date()),
        MainData(id: UUID(), name: "jpeg", image: UIImage(imageLiteralResourceName: "jpeg"), isImage: true, size: 0.01, insertDate: Date()),
        MainData(id: UUID(), name: "mp4", image: UIImage(imageLiteralResourceName: "mp4"), isImage: false, size: 0.01, insertDate: Date()),
    ]
    
    var body: some View {
        
        List(mainData) { data in
            MainRow(mainData: data)
                .onTapGesture(perform: {
                    image = Image(data.name)
                    showImageViewer = true
                })
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("ファイル",displayMode: .inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    // 削除処理
                }) {
                    Image(systemName: "trash")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    // 追加処理
                }) {
                    Image(systemName: "plus")
                }
            }
        })
        .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
