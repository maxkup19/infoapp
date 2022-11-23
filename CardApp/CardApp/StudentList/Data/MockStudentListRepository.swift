//
//  MockStudentListRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine
import Comet

final class MockStudentListRepository: StudentListRepositoryProtocol {
    func fetchStudentList() -> AnyPublisher<[Student], CometClientError> {
        Just(
            [
                Student(
                    id: "id1",
                    name: "name1",
                    platform: .iOS,
                    title: "iOS",
                    icon512: "icon",
                    homework: [
                        Homework(id: 1, number: 1, state: .acceptance)
                    ]
                ),
                Student(
                    id: "id2",
                    name: "name2",
                    platform: .android,
                    title: "Android",
                    icon512: "icon",
                    homework: [
                        Homework(id: 1, number: 1, state: .acceptance)
                    ]
                )
            ]
        )
        .setFailureType(to: CometClientError.self)
        .eraseToAnyPublisher()
    }
}
