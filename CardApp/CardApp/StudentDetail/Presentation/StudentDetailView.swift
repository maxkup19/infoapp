//
//  ContentView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 09.10.2022.
//

import SwiftUI

struct StudentDetailView<StudentDetailVM: StudentDetailViewModelProtocol>: View {
    
    @StateObject private var studentViewModel: StudentDetailVM
    
    init(studentViewModel: StudentDetailVM) {
        self._studentViewModel = StateObject(wrappedValue: studentViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    header
                    
                    socialMediaRow
                    
                    Divider()
                    
                    skillsBox
                    
                    homework
                    
                }
                .redacted(reason: studentViewModel.state != .success ? .placeholder : [])
                .padding(16)
            }
            .sheet(isPresented: $studentViewModel.showEditor) {
                SkillsEditorView(skillsEditorviewModel:
                                 SkillsEditorViewModel(student: studentViewModel.student,
                                                       studentUpdateSkillsUseCase: StudentUpdateSkillsUseCase(studentRepo: StudentDetailRepository())))
                    .presentationDetents([.medium])
            }
            .alert("Downloading error...", isPresented: $studentViewModel.showError) {
                Button {
                    studentViewModel.fetchStudent()
                } label: {
                    Text("Retry")
                }
            }
            .onAppear {
                studentViewModel.fetchStudent()
            }
            .onChange(of: studentViewModel.showEditor) { _ in
                studentViewModel.fetchStudent()
            }
            .refreshable {
                studentViewModel.fetchStudent()
            }
        }
    }
    
    private var header: some View {
        VStack {
            AsyncImage(url: URL(string: studentViewModel.student.icon512)!) {phase in
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
                if let skills = studentViewModel.student.skills {
                    ForEach(skills) { skill in
                        SkillView(imageName: skill.skillType.rawValue, value: skill.value)
                    }
                } else {
                    Text("Useless")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("textColor"))
                }
            }
            .padding(32)
            .frame(maxWidth: .infinity)
            .box()
            .contextMenu {
                if studentViewModel.editable {
                    Button("Edit") {
                        studentViewModel.showEditor = true
                    }
                }
            }
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

struct StudentDEatilView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDetailView(studentViewModel: StudentDetailViewModel(studentId: "maxkup19",
                                                                   studentDetailFetchUseCase: StudentDetailFetchWithIdUseCase(studentRepo: MockStudentDetailRepository())))
    }
}
