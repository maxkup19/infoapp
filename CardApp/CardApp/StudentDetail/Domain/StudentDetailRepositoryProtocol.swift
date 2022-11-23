//
//  StudentDetailRepositoryProtocol.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine
import Comet

protocol StudentDetailRepositoryProtocol {
    func fetchStudent(with id: String) -> AnyPublisher<StudentDetail, CometClientError>
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], CometClientError>
}
