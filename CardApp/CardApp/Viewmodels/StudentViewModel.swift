//
//  StudentViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import SwiftUI
import Combine

class StudentViewModel: ObservableObject {
    @Published private(set) var student: StudentFullInfo = Mock.redactedStudentFull
    @Published var error: Bool = false
    @Published private(set) var isLoading: Bool = false
    
    private var bag = Set<AnyCancellable>()

    init(by studentId: String) {
        fetchStudent(by: studentId)
    }
    
    func fetchStudent(by id: String) {
        self.isLoading = true
        
        StudentRepository.fetchStudent(by: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.error = false
                    self?.isLoading = false
                case .failure(_):
                    self?.error = true
                }
            }, receiveValue: { [weak self] student in
                self?.student = student
            })
            .store(in: &bag)
    }
}
