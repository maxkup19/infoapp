//
//  HomeworkItemView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 10.10.2022.
//

import SwiftUI

struct HomeworkItemView: View {
    
    let number: Int
    let pushed: Bool
    let reviewed: Bool
    let accepted: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(number)")
                .font(.system(size: 32, weight: .bold))
                .padding(20)
                .foregroundColor(.white)
                .background(Color.gray)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                HomeworkItemRowView(text: "PUSHED", predicate: pushed)
                HomeworkItemRowView(text: "REVIEWED", predicate: reviewed)
                HomeworkItemRowView(text: "ACCEPTED", predicate: accepted)
            }
        }
        .padding(16)
        .box()
        
        
    }
    
}

struct HomeworkItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeworkItemView(number: 1, pushed: true, reviewed: false, accepted: false)
    }
}
