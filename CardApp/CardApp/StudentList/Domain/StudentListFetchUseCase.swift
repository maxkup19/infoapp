//
//  StudentListFetchUseCase.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine
import Comet

protocol StudentListFetchUseCaseProtocol {
    func fetchStudentList() -> AnyPublisher<[Student], CometClientError>
}

final class StudentListFetchUseCase: StudentListFetchUseCaseProtocol {
    private let studentRepo: StudentListRepositoryProtocol
    
    init(studentRepo: StudentListRepositoryProtocol) {
        self.studentRepo = studentRepo
    }
    
    func fetchStudentList() -> AnyPublisher<[Student], CometClientError> {
        studentRepo.fetchStudentList()
    }
}
