//
//  HomeworkItemView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 10.10.2022.
//

import SwiftUI

struct HomeworkItemView: View {
    
    let homework: Homework
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(homework.number)")
                .font(.system(size: 32, weight: .bold))
                .padding(20)
                .foregroundColor(.white)
                .background(Color.gray)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                makeRow(text: "PUSHED",
                        predicate: homework.state >= .push)
                makeRow(text: "REVIEWED",
                        predicate: homework.state >= .review)
                makeRow(text: "ACCEPTED",
                        predicate: homework.state >= .acceptance)
            }
        }
        .padding(16)
        .box()
    }
    
    @ViewBuilder
    private func makeRow(text: String, predicate: Bool) -> some View {
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

struct HomeworkItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeworkItemView(homework: Homework(id: 2, number: 2, state: .review))
    }
}
