//
//  seminarApp.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/09.
//

import SwiftUI

@main
struct seminarApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { (url) in
                    guard let comp = NSURLComponents(url: url as URL, resolvingAgainstBaseURL: false) else {
                        return
                    }
                    let params = urlComponentsToDict(comp: comp)
                    let param1 = params["filename"]
                    if let h = param1 {
                        print("5てすとUniversal Link: \(h)")
                    }
                }
        }
    }
    
    func urlComponentsToDict(comp: NSURLComponents) -> Dictionary<String, String> {
        var dict: Dictionary<String, String> = Dictionary<String, String>()
        
        for i in 0..<comp.queryItems!.count {
            let item = comp.queryItems?[i] as! NSURLQueryItem
            dict[item.name] = item.value
        }
        
        return dict
    }
}
