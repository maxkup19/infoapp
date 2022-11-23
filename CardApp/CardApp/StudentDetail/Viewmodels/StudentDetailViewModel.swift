//
//  StudentViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import SwiftUI
import Combine

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
    
    private let studentRepo: StudentRepositoryProtocol
    private var bag = Set<AnyCancellable>()
    
    init(studentId: String, studentRepo: StudentRepositoryProtocol, editable: Bool = false) {
        self.editable = editable
        self.studentId = studentId
        self.studentRepo = studentRepo
    }
    
    func fetchStudent() {
        self.state = .loading
        
        studentRepo.fetchStudent(with: self.studentId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .success
                case .failure(_):
                    self?.state = .error
                    self?.showError = true
                }
            }, receiveValue: { [weak self] student in
                self?.student = student
            })
            .store(in: &bag)
    }
}
