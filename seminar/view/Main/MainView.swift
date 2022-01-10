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
        MainData(id: UUID(), name: "ほげほげ1.jpeg", image: UIImage(imageLiteralResourceName: "jpeg"), isImage: true, size: 0.01, insertDate: Date()),
        MainData(id: UUID(), name: "ほげほげ2.jpeg", image: UIImage(imageLiteralResourceName: "jpeg"), isImage: true, size: 0.01, insertDate: Date()),
        MainData(id: UUID(), name: "ほげほげ.mp4", image: UIImage(imageLiteralResourceName: "mp4"), isImage: false, size: 0.01, insertDate: Date()),
    ]
    
    var body: some View {
        
        List(mainData) { data in
            MainRow(mainData: data)
        }
        .listStyle(PlainListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
