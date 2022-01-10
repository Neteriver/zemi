//
//  VideoView.swift
//  seminar
//
//  Created by しゅん on 2022/01/10.
//

import SwiftUI
import AVKit

struct VideoView: View {

    // play river.mp4
    private let player:AVPlayer
    
    init(videoName:String) {
        player = AVPlayer(url: Bundle.main.url(forResource: videoName, withExtension: "mp4")!)
    }
    
    var body: some View {
        HStack{
            VideoPlayer(player: player)
                .onAppear() {
                    self.player.play()
                }.onDisappear() {
                    self.player.pause()
                }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var videoName = "hoge"
    static var previews: some View {
        VideoView(videoName: videoName)
    }
}
