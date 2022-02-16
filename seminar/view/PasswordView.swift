//
//  PasswordView.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/14.
//

import SwiftUI
import Introspect

public struct PasswordView: View {
    
    var maxDigits: Int = 4
    @State var label = "パスコードを入力してください"
    
    @State var pin: String = ""
    @State var showPin = false
    @State var isDisabled = false
    
    var handler: (String, (Bool) -> Void) -> Void
    
    let width = UIScreen.main.bounds.width
    
    public var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(red: 0.7490196078431373, green: 0.615686274509804, blue: 0.3686274509803922))
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: width - 20, height: nil, alignment: .center)
                .foregroundColor(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9490196078431372))
                .padding(.top)
            
            VStack {
                Text(label).font(.title)
                ZStack {
                    pinDots
                    backgroundField
                }
                showPinStack
            }
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
      
      // Introspect library can used to make the textField become first resonder on appearing
      // if you decide to add the pod 'Introspect' and import it, comment #50 to #53 and uncomment #55 to #61
//
//           .accentColor(.clear)
//           .foregroundColor(.clear)
//           .keyboardType(.numberPad)
//           .disabled(isDisabled)
      
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
        guard !pin.isEmpty else {
            showPin = false
            return
        }
        
        if pin.count == maxDigits {
            isDisabled = true
            
            handler(pin) { isSuccess in
                if isSuccess {
                    // パスコードの照合が成功した時の処理
                    print("パスワード照合成功")
                } else {
                    // パスコードの処理が失敗した時の処理
                    pin = ""
                    isDisabled = false
                    label = "パスワードが違います"
                }
            }
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
        // max digits, we remove the additional characters and make a recursive call.
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

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}
