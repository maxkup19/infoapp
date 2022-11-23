//
//  StudentDetailFetchWithIdUseCase.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Comet
import Combine

protocol StudentDetailFetchWithIdUseCaseProtocol {
    func fetchStudent(with id: String) -> AnyPublisher<StudentDetail, CometClientError>
}

final class StudentDetailFetchWithIdUseCase: StudentDetailFetchWithIdUseCaseProtocol {
    private let studentRepo: StudentDetailRepositoryProtocol
    
    init(studentRepo: StudentDetailRepositoryProtocol) {
        self.studentRepo = studentRepo
    }
    
    func fetchStudent(with id: String) -> AnyPublisher<StudentDetail, CometClientError> {
        studentRepo.fetchStudent(with: id)
    }
}
