//
//  StudentUpdateSkillsUseCase.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine
import Comet

protocol StudentUpdateSkillsUseCaseProtocol {
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], CometClientError>
}

final class StudentUpdateSkillsUseCase: StudentUpdateSkillsUseCaseProtocol {
    private let studentRepo: StudentDetailRepositoryProtocol
    
    init(studentRepo: StudentDetailRepositoryProtocol) {
        self.studentRepo = studentRepo
    }
    
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], CometClientError> {
        studentRepo.updateSkills(for: student)
    }
}
