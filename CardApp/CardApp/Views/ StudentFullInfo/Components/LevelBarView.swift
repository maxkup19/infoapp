//
//  LevelBarView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 10.10.2022.
//

import SwiftUI

struct LevelBarView: View {
    
    let level: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...10, id: \.self) { value in
                Rectangle()
                    .foregroundColor(value <= level ? Color("levelItemColor") : .gray)
            }
        }
        .clipShape(Capsule())
    }
    
}

struct LevelBarView_Previews: PreviewProvider {
    static var previews: some View {
        LevelBarView(level: 3)
            .frame(height: 30)
            .padding()
    }
}
