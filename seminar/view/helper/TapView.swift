//
//  TapView.swift
//  seminar
//
//  Created by しゅん on 2022/01/08.
//

import SwiftUI

struct TapView: UIViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)

    func makeUIView(context: UIViewRepresentableContext<TapView>) -> TapView.UIViewType {
        let v = UIView(frame: .zero)
        let gesture = SingleTouchDownGestureRecognizer(target: context.coordinator,
                                                       action: #selector(Coordinator.tapped))
        v.addGestureRecognizer(gesture)
        return v
    }

    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)

        init(tappedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
        }

        @objc func tapped(gesture:UITapGestureRecognizer) {
            self.tappedCallback(gesture.location(in: gesture.view))
        }
    }

    func makeCoordinator() -> TapView.Coordinator {
        return Coordinator(tappedCallback:self.tappedCallback)
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<TapView>) {
    }
}

class SingleTouchDownGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        pressStrength(touches: touches)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        pressStrength(touches: touches)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        pressStrength(touches: touches)
    }
    
    func pressStrength(touches: Set<UITouch>) {
//        if UITraitCollection.forceTouchCapability == .available {
            for touch:UITouch in touches {
//                let strength = Float(touch.force / touch.maximumPossibleForce)
                print(touch.force)
            }
//        }
    }
}
