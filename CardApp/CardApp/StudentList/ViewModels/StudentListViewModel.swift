//
//  StudentListViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import Foundation
import Combine

class StudentListViewModel: ObservableObject {
    @Published private(set) var students: [Student] = Array(repeating: Mock.redactedStudent, count: 5)
    @Published private(set) var state: FetchState = .loading
 
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
                }
            }, receiveValue: { [weak self] students in
                self?.students = students
            })
            .store(in: &bag)
    }
}
