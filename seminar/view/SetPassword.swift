//
//  SetLocationAuth.swift
//  seminar
//
//  Created by 石井快思 on 2022/01/20.
//

// 認証可能な座標を設定する画面

import SwiftUI
import Introspect

public struct SetPassword: View {
    
    @ObservedObject var passwordAuth = PasswordAuth()
    
    @Binding var passcord:String
    
    var maxDigits: Int = 4
    @State var label = "パスコードを入力してください"
    
    @State var pin: String = ""
    @State var showPin = false
    @State var isDisabled = false
    @State var initFlag = false
    
//    var handler: (String, (Bool) -> Void) -> Void
    
    public var body: some View {
        VStack {
            Text(label).font(.title)
            ZStack {
                pinDots
                backgroundField
            }
            showPinStack
        }
        
    }
    
    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0..<maxDigits) { index in
                Image(systemName: self.getImageName(at: index))
                Spacer()
            }
        }
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        
        return TextField("", text: boundPin, onCommit: submitPin)
             .introspectTextField { textField in
                 textField.tintColor = .clear
                 textField.textColor = .clear
                 textField.keyboardType = .numberPad
                 textField.becomeFirstResponder()
                 textField.isEnabled = !self.isDisabled
         }
    }
    
    private var showPinStack: some View {
        HStack {
            Spacer()
            if !pin.isEmpty {
                showPinButton
            }
        }
        .frame(height: 100)
        .padding([.trailing])
    }

    private var showPinButton: some View {
        Button(action: {
            self.showPin.toggle()
        }, label: {
            self.showPin ?
                Image(systemName: "eye.slash.fill").foregroundColor(.primary) :
                Image(systemName: "eye.fill").foregroundColor(.primary)
        })
    }
    
    private func submitPin() {
        // pinが空文字の時の処理
        guard !pin.isEmpty else {
            showPin = false
            return
        }
        // pinの文字数が最大文字数と一致している時の処理
        if pin.count == maxDigits {
            isDisabled = true


        }

        // 最大文字数を超えたテキストを貼り付けた場合、追加された文字を削除し、再帰的な呼び出しを行う
        if pin.count > maxDigits {
            pin = String(pin.prefix(maxDigits))
            submitPin()
        }
    }
    
    private func getImageName(at index: Int) -> String {
        if index >= self.pin.count {
            return "circle"
        }
        
        if self.showPin {
            return self.pin.digits[index].numberString + ".circle"
        }
        
        return "circle.fill"
    }
}
