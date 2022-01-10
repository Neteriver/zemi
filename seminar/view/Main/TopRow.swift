//
//  TopRow.swift
//  seminar
//
//  Created by しゅん on 2022/01/10.
//

import SwiftUI

struct TopRow: View {
    
    var title:String
    
    var imageName:String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .renderingMode(.original)
                .font(.title)
            Text(title)
            Spacer()
        }
    }
}

struct TopRow_Previews: PreviewProvider {
    static var title = "hogehoge"
    static var systemName = "folder.circle.fill"
    static var previews: some View {
        TopRow(title: title, imageName: systemName)
    }
}
