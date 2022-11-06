//
//  StudentRowView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import SwiftUI

struct StudentRowView: View {
    
    let student: StudentOverallInfo
    
    var body: some View {
        HStack(spacing: 32) {
            
            rowHeader
            
            rowLabel
        }
    }
    
    private var rowHeader: some View {
        
        AsyncImage(url: URL(string: student.icon512)!) { image in
            image
                .resizable()
        } placeholder: {
            Color.gray
        }
        .frame(width: 80, height: 80)
        .clipShape(Circle())
        .overlay {
            Image(student.participantType == .iOS ? "swift-badge" : "android-badge")
                .resizable()
                .frame(width: 35, height: 35)
                .offset(x: 25, y: 25)
        }
        
    }
    
    private var rowLabel: some View {
        VStack(alignment: .leading) {
            Text(student.name)
                .font(.system(size: 18))
                .foregroundColor(Color("textColor").opacity(0.7))
            
            HStack(spacing: 6) {
                if let homeworks = student.homework {
                    ForEach(homeworks.filter { $0.state != .comingsoon }) { homework in
                        makeHomeworkItem(homework: homework)
                    }
                }
            }
            
        }
    }
    
    @ViewBuilder
    private func makeHomeworkItem(homework: Homework) -> some View {
        Text("\(homework.number)")
            .foregroundColor(Color("bgColor"))
            .padding(10)
            .background(
                Circle()
                    .foregroundColor(homework.state == .acceptance ? Color("textColor") : .gray)
            )
    }
    
}

struct StudentRowView_Previews: PreviewProvider {
    static var previews: some View {
        StudentRowView(student: Mock.redactedStudentOverall)
    }
}
