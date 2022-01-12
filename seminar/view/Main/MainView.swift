//
//  MainView.swift
//  seminar
//
//  Created by しゅん on 2022/01/10.
//

import SwiftUI
import ImageViewer
import MobileCoreServices

struct MainView: View {
    
    // イメージ出力用
    @State var showImageViewer: Bool = false
    @State var image = Image("example-image")
    
    @State var mainData:[MainData] = [
        MainData(id: UUID(), name: "jpeg", url: URL(string: "https://www.hcs.ac.jp/")!, isImage: true, size: "1.01 MB", insertDate: Date()),
        MainData(id: UUID(), name: "jpeg", url: URL(string: "https://www.hcs.ac.jp/")!, isImage: true, size: "1.01 MB", insertDate: Date()),
        MainData(id: UUID(), name: "mp4", url: URL(string: "https://www.hcs.ac.jp/")!, isImage: false, size: "1.01 MB", insertDate: Date()),
    ]
    
    var body: some View {
        
        List(mainData) { data in
            MainRow(mainData: data)
                .onTapGesture(perform: {
                    let data = try! Data(contentsOf: data.url)
                    let uiimage = UIImage(data: data)
                    image = Image(uiImage: uiimage!)
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
        .onAppear(perform: {
            let datalist = readFromFile()
            mainData.removeAll()
            mainData = datalist
            
        })
        .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer))
    }
    
    func readFromFile() -> [MainData] {
        guard let dirURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.seminar.kaijiIshii") else {
            fatalError("")
        }
        print(dirURL.path)
        guard let fileNames = try? FileManager.default.contentsOfDirectory(atPath: dirURL.path) else {
            fatalError("")
        }
        
        var mainData:[MainData] = []
        for fileName in fileNames  {
            let fullpath = dirURL.appendingPathComponent(fileName)
            guard let content = try? Data(contentsOf: fullpath) else {
                break
            }
            guard let _ = UIImage(data: content) else {
                break
            }
            let attr = try! FileManager.default.attributesOfItem(atPath: fullpath.path) as NSDictionary
            let size = Util.formatSize(size: attr.fileSize())
            guard let insertDate = attr.fileCreationDate() else {
                break
            }
            let data = MainData(id: UUID(), name: fileName, url: fullpath, isImage: true, size: size, insertDate: insertDate)
            mainData.append(data)
        }
        return mainData
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
