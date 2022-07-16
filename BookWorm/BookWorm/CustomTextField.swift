//
//  CustomTextField.swift
//  BookWorm
//
//  Created by Noah Glaser on 7/15/22.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String 
    
    @Binding var isValid: Bool
    
    let fieldName: String
    
    var body: some View {
        VStack {
            TextField(fieldName, text: $text)
            if !isValid {
                GeometryReader { geo in
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: geo.size.width, height: 2)
                        
                }
            }
            
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("Test"), isValid: .constant(true), fieldName: "Text Field")
    }
}
