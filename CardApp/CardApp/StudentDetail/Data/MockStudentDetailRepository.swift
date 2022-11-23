//
//  MockStudentdetailRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine
import Comet

final class MockStudentDetailRepository: StudentDetailRepositoryProtocol {
    func fetchStudent(with id: String) -> AnyPublisher<StudentDetail, CometClientError> {
        Just(
            StudentDetail(
                id: "id1",
                name: "name1",
                title: "iOS Lead",
                platform: .iOS,
                slackURL: "url",
                icon512: "icon",
                skills: [
                    .init(skillType: .android, value: 10)
                ],
                homework: [
                    .init(id: 1, number: 1, state: .acceptance)
                ]
            )
        )
        .setFailureType(to: CometClientError.self)
        .eraseToAnyPublisher()
    }
    
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], CometClientError> {
        Just(Mock.skills)
            .setFailureType(to: CometClientError.self)
            .eraseToAnyPublisher()
    }
}
