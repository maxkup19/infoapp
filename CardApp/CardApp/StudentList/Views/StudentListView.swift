//
//  StartView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import SwiftUI

struct StudentListView: View {
    
    @StateObject private var studentListVM = StudentListViewModel()
    
    @State private var selection: Platform = .all
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                picker
                studentList
            }
            .navigationTitle("Participants")
        }
        .alert("Downloading failed...", isPresented: self.$showError) {
            Button {
                studentListVM.fetchStudentList()
            } label: {
                Text("Retry")
            }
        }
        .onAppear {
            if studentListVM.state != .success && LoginRepository.tokenExists  {
                studentListVM.fetchStudentList()
            }
        }
        .onReceive(studentListVM.$state) { state in
            self.showError = state == .error
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
            studentListVM.students
                .filter {
                    switch selection {
                    case .all:
                        return true
                    case .android:
                        return  $0.platform == .android
                    case .iOS:
                        return  $0.platform == .iOS
                    }
                }
        ) { student in
            NavigationLink {
                StudentDetailView(studentId: student.id)
                    .navigationTitle(student.name)
            } label: {
                StudentRowView(student: student)
                    .redacted(reason: studentListVM.state != .success ? .placeholder : [])
            }
            .disabled(studentListVM.state != .success)
            
        }
        .listStyle(.plain)
    }
    
}

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView()
    }
}
