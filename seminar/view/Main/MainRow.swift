//
//  MainRow.swift
//  seminar
//
//  Created by しゅん on 2022/01/10.
//

import SwiftUI

struct MainRow: View {
    
    var mainData:MainData
    
    var body: some View {
        HStack {
            
            if(mainData.isImage) {
                // 商品画像
                Image("jpeg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 70, alignment: .leading)
            } else {
                Image("mp4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 70, alignment: .leading)
            }
            
            // 商品名
            VStack(alignment: .leading) {
                Text(mainData.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(10)
                // 価格
                HStack {
                    Text("\(dateFormat(date: mainData.insertDate))")
                        .font(.caption2)
                        .foregroundColor(Color.gray)
                    
                    Text("\(mainData.size)")
                        .font(.caption2)
                        .foregroundColor(Color.gray)
                }.padding(.leading, 10)
                    
            }
            
            Spacer()
            
            Text("︙")
                .font(.title2)
                .foregroundColor(Color.gray)
                .bold()
            
            
        }.padding(.horizontal, 10.0)
    }
    
    func dateFormat(date:Date) -> String {
        // Date ⇔ Stringの相互変換をしてくれるすごい人
        let dateFormatter = DateFormatter()
        // フォーマット設定
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"

        // ロケール設定（端末の暦設定に引きづられないようにする）
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        // タイムゾーン設定（端末設定によらず固定にしたい場合）
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

        // 変換
        let str = dateFormatter.string(from: date)

        // 結果表示
        return str
    }
}

struct MainRow_Previews: PreviewProvider {
    
    static var mainData:MainData = MainData(id: UUID(), name: "北海道情報専門学校の裏掲示板の正体とは.jpeg", url: URL(string: "https://www.hcs.ac.jp/")!, isImage: true, size: "1.01 MB", insertDate: Date())
    
    static var previews: some View {
        MainRow(mainData:mainData)
    }
}
