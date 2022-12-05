//
//  StudentUpdateSkillsUseCase.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine

protocol StudentUpdateSkillsUseCaseProtocol {
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], StudentDetailError>
}

final class StudentUpdateSkillsUseCase: StudentUpdateSkillsUseCaseProtocol {
    private let studentRepo: StudentDetailRepositoryProtocol
    
    init(studentRepo: StudentDetailRepositoryProtocol) {
        self.studentRepo = studentRepo
    }
    
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], StudentDetailError> {
        studentRepo.updateSkills(for: student)
    }
}
