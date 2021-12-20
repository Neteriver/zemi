//
//  FlickView.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/20.
//

import SwiftUI

struct FlickView: View {
    
    let flickAuth:FlickAuth = FlickAuth()
    
    var body: some View {
        Text("フリック認証画面").onAppear{
            flickAuth.develop()
        }
    }
}

struct FlickView_Previews: PreviewProvider {
    static var previews: some View {
        FlickView()
    }
}
