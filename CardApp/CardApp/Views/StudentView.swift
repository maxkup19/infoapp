//
//  ContentView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 09.10.2022.
//

import SwiftUI

struct StudentView: View {
    
    let student: Student
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header
                
                socialMediaRow
                
                Divider()
                
                skillsBox
                
                homework
                
            }
            .padding(16)
        }
    }
    
    private var header: some View {
        VStack {
            Image(student.image)
                .resizable()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
            
            Text("\(student.platform == .android ? "🤖" : "🍏") \(student.platform.rawValue) developer")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
        }
    }
    
    private var socialMediaRow: some View {
        HStack {
            Spacer()
            SMItemView(imageName: "slack", title: "Slack", destination: "etneteramobil-tjp5021.slack.com\(student.slackId)")
            Spacer()
            SMItemView(imageName: "email", title: "E-mail", destination: "mailto:\(student.email)")
            Spacer()
            SMItemView(imageName: "linkedin", title: "Linkedin", destination: student.linkedInLink ?? "https://www.linkedin.com")
            Spacer()
        }
    }
    
    private var skillsBox: some View {
        VStack(alignment: .leading) {
            Text("Skills")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("textColor"))
            
            VStack(alignment: .leading, spacing: 16) {
                SkillView(imageName: "swift", value: Int.random(in: 1...10))
                SkillView(imageName: "apple", value: Int.random(in: 1...10))
                SkillView(imageName: "kotlin", value: Int.random(in: 1...10))
                SkillView(imageName: "android", value: Int.random(in: 1...10))
            }
            .padding(32)
            .box()
            
        }
    }
    
    private var homework: some View {
        VStack(alignment: .leading) {
            Text("Homework")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("textColor"))
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(student.homeworks) { homework in
                        HomeworkItemView(homework: homework)
                            .padding(.vertical)
                            .frame(width: 200)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.never)
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(student: Mock.student)
    }
}
