//
//  LoginRowView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct LoginRowView: View {
    
    let prompt: String
    @Binding var data: String
    
    // MARK: IN CASE OF USING TO ENTER PASSWORD isPrivate should be true
    var isPrivate: Bool = false
    
    var body: some View {
        if isPrivate  {
            SecureField(prompt, text: $data)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke()
                }
            
        } else {
            TextField(prompt, text: $data)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke()
                }
        }
    }
}

struct LoginRowView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRowView(prompt: "Username", data: .constant(""), isPrivate: true)
            .padding()
    }
}
