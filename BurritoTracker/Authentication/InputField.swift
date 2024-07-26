//
//  InputField.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/24/24.
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12){
            Text(title)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))

            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))

            }
            
            Divider()
            
        }
    }
}

#Preview {
    InputField(text: .constant("Title"), title: "Email Address", placeholder: "matt@example.com")
}
