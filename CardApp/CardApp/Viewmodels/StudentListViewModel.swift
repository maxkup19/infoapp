//
//  StudentListViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import Foundation
import Combine

class StudentListViewModel: ObservableObject {
    @Published private(set) var students: [StudentOverallInfo] = Array(repeating: Mock.redactedStudentOverall, count: 5)
    @Published var error: Bool = false
    @Published private(set) var isLoading = false
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        fetchStudents()
    }
    
    func fetchStudents() {
        self.isLoading = true
        
        StudentRepository.fetchStudents()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.error = false
                    self?.isLoading = false
                case .failure(_):
                    self?.error = true
                }
            }, receiveValue: { [weak self] students in
                self?.students = students
            })
            .store(in: &bag)
        
    }
}
