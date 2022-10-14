//
//  BoxViewModifier.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 10.10.2022.
//

import SwiftUI

extension View {
    func box() -> some View {
        self.modifier(BoxViewModifier())
    }
}

struct BoxViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("boxColor"))
                    .shadow(color: .black.opacity(0.2) ,radius: 12)
            )
    }
}
