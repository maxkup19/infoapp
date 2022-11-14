//
//  StudentListViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import Foundation
import Combine


protocol StudentListViewModelProtocol: ObservableObject {
    var students: [Student] { get }
    var state: FetchState { get }
    
    var selection: Platform { get set }
    var showError: Bool { get set }
    
    func fetchStudentList()
}


class StudentListViewModel: StudentListViewModelProtocol {
    @Published private(set) var students: [Student] = Array(repeating: Mock.redactedStudent, count: 5)
    @Published private(set) var state: FetchState = .loading
    @Published var selection: Platform = .all
    @Published var showError: Bool = false
 
    private let studentRepo: StudentRepositoryProtocol = StudentRepository()
    private var bag = Set<AnyCancellable>()
    
    func fetchStudentList() {
        self.state = .loading
        
        studentRepo.fetchStudentList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .success
                case .failure(_):
                    self?.state = .error
                    self?.showError = true
                }
            }, receiveValue: { [weak self] students in
                self?.students = students
            })
            .store(in: &bag)
    }
}
