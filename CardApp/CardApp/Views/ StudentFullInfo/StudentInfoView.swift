//
//  ContentView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 09.10.2022.
//

import SwiftUI

struct StudentInfoView: View {

    @ObservedObject private var studentViewModel: StudentViewModel
    let studentId: String
    
    init(studentId: String) {
        self.studentId = studentId
        self.studentViewModel = StudentViewModel(by: studentId)
    }

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
        .redacted(reason: studentViewModel.isLoading ? .placeholder : [])
        .alert("Downloading error...", isPresented: $studentViewModel.error) {
            Button {
                studentViewModel.fetchStudent(by: self.studentId)
            } label: {
                Text("Retry")
            }
        }
    }

    private var header: some View {
        VStack {
            AsyncImage(url: URL(string: studentViewModel.student.icon192)!) {phase in
                if let image = phase.image {
                    image
                        .resizable()
                }
                else {
                    Color.gray
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                }
            }
            .frame(width: 140, height: 140)
            .clipShape(Circle())

            Text(studentViewModel.student.title)
                .font(.system(size: 16))
                .foregroundColor(.gray)

        }
    }

    private var socialMediaRow: some View {
        HStack {
            Spacer()
            SMItemView(imageName: "slack", title: "Slack", destination: studentViewModel.student.slackURL)
            Spacer()
            SMItemView(imageName: "email", title: "E-mail", destination: "mailto:mail@mail.com")
            Spacer()
            SMItemView(imageName: "linkedin", title: "Linkedin", destination: "https://www.linkedin.com")
            Spacer()
        }
    }

    private var skillsBox: some View {
        VStack(alignment: .leading) {
            Text("Skills")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("textColor"))

            VStack(alignment: .leading, spacing: 16) {
                ForEach(studentViewModel.student.skills, id:\.self) { skill in
                    SkillView(imageName: skill.skillType.rawValue, value: skill.value)
                }
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
                    ForEach(studentViewModel.student.homework) { homework in
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

struct StudentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StudentInfoView(studentId: "maxkup19")
    }
}
