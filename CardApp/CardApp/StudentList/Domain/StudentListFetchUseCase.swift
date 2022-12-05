//
//  StudentListFetchUseCase.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine

protocol StudentListFetchUseCaseProtocol {
    func fetchStudentList() -> AnyPublisher<[Student], StudentError>
}

final class StudentListFetchUseCase: StudentListFetchUseCaseProtocol {
    private let studentRepo: StudentListRepositoryProtocol
    
    init(studentRepo: StudentListRepositoryProtocol) {
        self.studentRepo = studentRepo
    }
    
    func fetchStudentList() -> AnyPublisher<[Student], StudentError> {
        studentRepo.fetchStudentList()
    }
}
