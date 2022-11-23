//
//  StartView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import SwiftUI

struct StudentListView<StudentListVM: StudentListViewModelProtocol>: View {
    
    @StateObject private var studentListViewModel: StudentListVM
    
    init(studentListViewModel: StudentListVM) {
        self._studentListViewModel = StateObject(wrappedValue: studentListViewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                picker
                studentList
            }
            .navigationTitle("Participants")
        }
        .alert("Downloading failed...", isPresented: $studentListViewModel.showError) {
            Button {
                studentListViewModel.fetchStudentList()
            } label: {
                Text("Retry")
            }
        }
        .onAppear {
            if studentListViewModel.state != .success && LoginRepository.loggedIn  {
                studentListViewModel.fetchStudentList()
            }
        }
    }
    
    private var picker: some View {
        Picker("Participants", selection: $studentListViewModel.selection) {
            ForEach(Platform.allCases) { value in
                Text(value.localized).tag(value)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var studentList: some View {
        List(studentListViewModel.displayedStudents) { student in
            NavigationLink {
                StudentDetailView(studentViewModel: StudentDetailViewModel(studentId: student.id,
                                                                           studentDetailFetchUseCase: StudentDetailFetchWithIdUseCase(studentRepo: StudentDetailRepository())))
                    .navigationTitle(student.name)
            } label: {
                StudentRowView(student: student)
                    .redacted(reason: studentListViewModel.state != .success ? .placeholder : [])
            }
            .disabled(studentListViewModel.state != .success)
            
        }
        .listStyle(.plain)
        .refreshable {
            studentListViewModel.fetchStudentList()
        }
    }
    
}

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView(studentListViewModel: StudentListViewModel(studentlistFetchUseCase: StudentListFetchUseCase(studentRepo: MockStudentListRepository()),
                                                                   studentListFilterUseCase: StudentListFilterUseCase()))
    }
}
