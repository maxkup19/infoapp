//
//  StudentViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import SwiftUI
import Combine
import CombineExtensions

protocol StudentDetailViewModelProtocol: ObservableObject {
    var student: StudentDetail { get }
    var state: FetchState { get }
    var editable: Bool { get }
    var showError: Bool { get set }
    var showEditor: Bool { get set }
    
    func fetchStudent()
}

class StudentDetailViewModel: StudentDetailViewModelProtocol {
    @Published private(set) var student: StudentDetail = Mock.redactedStudentDetail
    @Published private(set) var state: FetchState = .loading
    @Published var editable: Bool
    @Published var showError: Bool = false
    @Published var showEditor: Bool = false
    
    private var studentId: String
    
    private let studentDetailFetchUseCase: StudentDetailFetchWithIdUseCaseProtocol
    private var bag = Set<AnyCancellable>()
    
    init(studentId: String, studentDetailFetchUseCase: StudentDetailFetchWithIdUseCaseProtocol, editable: Bool = false) {
        self.editable = editable
        self.studentId = studentId
        self.studentDetailFetchUseCase = studentDetailFetchUseCase
    }
    
    func fetchStudent() {
        self.state = .loading
        
        studentDetailFetchUseCase.fetchStudent(with: self.studentId)
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
                receiveValue: { unwrappedSelf, student in
                    unwrappedSelf.student = student
                })
            .store(in: &bag)
    }
}
