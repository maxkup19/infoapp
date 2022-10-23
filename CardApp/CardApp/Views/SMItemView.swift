//
//  SMItemView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 09.10.2022.
//

import SwiftUI

struct SMItemView: View {
    
    let imageName: String
    let title: String
    let destination: String
    
    var body: some View {
        if let destination = URL(string: destination) {
            Link(destination: destination) {
                VStack {
                    Image(imageName)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding()
                        .background(
                            Color.gray.opacity(0.2)
                        )
                        .clipShape(Circle())
                    
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(Color("textColor"))
            }
        }
    }
}

struct SMItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            SMItemView(imageName: "slack", title: "Slack", destination: "apple.com")
            SMItemView(imageName: "email", title: "E-mail", destination: "apple.com")
        }
    }
}
