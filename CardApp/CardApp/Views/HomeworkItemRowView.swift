//
//  HomeworkItemRowView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 11.10.2022.
//

import SwiftUI

struct HomeworkItemRowView: View {
    
    let text: String
    let predicate: Bool
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
            Spacer()
            Image(systemName: "\(predicate ? "checkmark.circle.fill" : "clock.fill")")
                .foregroundColor(predicate ? .green : .gray)
            
        }
    }
}

struct HomeworkItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeworkItemRowView(text: "ACCEPTED", predicate: true)
    }
}
