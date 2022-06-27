//
//  UITextFieldRepresentable.swift
//  UIKit_SwiftUI
//
//  Created by navaneeth-pt4855 on 27/06/22.
//

import SwiftUI
import UIKit

struct UITextFieldRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    
    let textField = UITextField(frame: .zero)
    
    init(keyboardType: UIKeyboardType, text: Binding<String>){
        textField.keyboardType = keyboardType
        self._text = text
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        textField.delegate = context.coordinator
        return textField
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate{
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
    
}

struct UITextFieldRepresentable_Previews: PreviewProvider {
    @State static var text = "1234"
    static var previews: some View {
        UITextFieldRepresentable(keyboardType: .numberPad, text: $text)
    }
}
