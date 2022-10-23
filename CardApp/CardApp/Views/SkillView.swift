//
//  ExperienceRowView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 09.10.2022.
//

import SwiftUI

struct SkillView: View {
    
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
                
        }
    }
}

struct ExperienceRowView_Previews: PreviewProvider {
    static var previews: some View {
        SkillView(imageName: "swift", value: 8)
            .frame(height: 40)
    }
}
