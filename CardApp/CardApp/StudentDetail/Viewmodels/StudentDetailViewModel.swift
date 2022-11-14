//
//  StudentViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import SwiftUI
import Combine

class StudentDetailViewModel: ObservableObject {
    @Published private(set) var student: StudentDetail = Mock.redactedStudentDetail
    @Published private(set) var state: FetchState = .loading
    
    private let studentRepo: StudentRepositoryProtocol = StudentRepository()
    private var bag = Set<AnyCancellable>()
    
    func fetchStudent(with id: String) {
        self.state = .loading
        
        studentRepo.fetchStudent(with: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .success
                case .failure(_):
                    self?.state = .error
                }
            }, receiveValue: { [weak self] student in
                self?.student = student
            })
            .store(in: &bag)
    }
}
