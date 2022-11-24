//
//  StudentListViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import Foundation
import Combine
import CombineExtensions


protocol StudentListViewModelProtocol: ObservableObject {
    var displayedStudents: [Student] { get }
    var state: FetchState { get }
    
    var selection: Platform { get set }
    var showError: Bool { get set }
    
    func fetchStudentList()
}


class StudentListViewModel: StudentListViewModelProtocol {
    @Published private(set) var state: FetchState = .loading
    @Published var selection: Platform = .all
    @Published var showError: Bool = false
    
    var displayedStudents: [Student] {
        studentListFilterUseCase.filter(students: students, by: selection)
    }
    
    private var students: [Student] = Array(repeating: Mock.redactedStudent, count: 5)
    private let studentlistFetchUseCase: StudentListFetchUseCaseProtocol
    private let studentListFilterUseCase: StudentListFilterUseCaseProtocol
    private var bag = Set<AnyCancellable>()
    
    init(studentlistFetchUseCase: StudentListFetchUseCaseProtocol, studentListFilterUseCase: StudentListFilterUseCaseProtocol) {
        self.studentlistFetchUseCase = studentlistFetchUseCase
        self.studentListFilterUseCase = studentListFilterUseCase
    }
    
    func fetchStudentList() {
        self.state = .loading
        
        studentlistFetchUseCase.fetchStudentList()
            .receive(on: DispatchQueue.main)
            .sink(
                weak: self,
                receiveCompletion: { unwrappedSelf, completion in
                    switch completion {
                    case .finished:
                        unwrappedSelf.state = .success
                    case .failure(_):
                        unwrappedSelf.state = .error
                        unwrappedSelf.showError = true
                    }
                },
                receiveValue: { unwrappedSelf, students in
                    unwrappedSelf.students = students
                })
            .store(in: &bag)
    }
}
