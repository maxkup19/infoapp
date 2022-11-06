//
//  StartView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import SwiftUI

struct StudentListView: View {
    
    @ObservedObject private var studentListvm = StudentListViewModel()
    @State private var selection: Platform = .all
    
    var body: some View {
        NavigationStack {
            VStack {
                picker
                studentList
            }
            .navigationTitle("Participants")
        }
        .alert("Downloading failed...", isPresented: $studentListvm.error) {
            Button {
                studentListvm.fetchStudents()
            } label: {
                Text("Retry")
            }
        }
    }
    
    private var picker: some View {
        Picker("Participants", selection: $selection) {
            ForEach(Platform.allCases) { value in
                Text(value.localized).tag(value)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var studentList: some View {
        List(
            studentListvm.students
                .filter {
                    switch selection {
                    case .all:
                        return true
                    case .android:
                        return  $0.participantType == .android
                    case .iOS:
                        return  $0.participantType == .iOS
                    }
                }
                .sorted(by: { $0.name < $1.name })
        ) { student in
            NavigationLink {
                StudentInfoView(studentId: student.id)
                    .navigationTitle(student.name)
            } label: {
                StudentRowView(student: student)
                    .redacted(reason: studentListvm.isLoading ? .placeholder : [])
            }
            
        }
        .listStyle(.plain)
    }
    
}

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView()
    }
}
