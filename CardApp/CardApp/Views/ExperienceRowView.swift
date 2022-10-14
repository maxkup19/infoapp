//
//  ExperienceRowView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 09.10.2022.
//

import SwiftUI

struct ExperienceRowView: View {
    
    let imageName: String
    let value: Int
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 38, height: 38)
            
            Spacer()
            
            LevelBarView(level: value)
                .padding()
            
//            Rectangle()
//                .offset(x: value < 2 ? -10 : 0)
//                .offset(x: value > 9 ? 10 : 0)
//                .clipShape(Capsule())
//                .padding()
            
//            MARK: - Mandatory
//            Text("\(value)/10")
//                .foregroundColor(.mint)
                
        }
    }
}

struct ExperienceRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceRowView(imageName: "swift", value: 8)
            .frame(width: 200, height: 40)
    }
}
