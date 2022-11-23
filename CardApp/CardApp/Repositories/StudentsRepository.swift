//
//  SudentsRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import Foundation
import Combine
import Comet

protocol StudentRepositoryProtocol {
    func fetchStudentList() -> AnyPublisher<[Student], CometClientError>
    func fetchStudent(with id: String) -> AnyPublisher<StudentDetail, CometClientError>
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], CometClientError>
}

final class CometStudentRepository: StudentRepositoryProtocol {
    private let userDefaultsRepo: UserDefaultsRepository = .init()
    private let loginRepo: LoginRepository = .init()
    private var bag = Set<AnyCancellable>()
    
    private let cometClient: CometClient = CometClient(tokenProvider: TokenProvider(),
                                                       authenticatedRequestBuilder: AuthenticatedRequestBuilder())
    
    func fetchStudentList() -> AnyPublisher<[Student], CometClientError> {
        let request = RequestBuilder
            .createRequest(for: "http://emarest.cz.mass-php-1.mit.etn.cz/api/v2/participants?sort=asc&sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)",
            with: .init(method: "GET",
                        httpBody: nil,
                        headers: ["application/json": "Content-Type"],
                        authentorized: false))
        
        return cometClient.performAuthenticatedRequest(request,
                                                responseType: [Student].self)
    }
    
    func fetchStudent(with id: String) -> AnyPublisher<StudentDetail, CometClientError> {
        let request = RequestBuilder
            .createRequest(for: "http://emarest.cz.mass-php-1.mit.etn.cz/api/v2/participants/\(id)?sort=asc&sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)",
            with: .init(method: "GET",
                        httpBody: nil,
                        headers: ["application/json": "Content-Type"],
                        authentorized: false))
        
        return cometClient.performAuthenticatedRequest(request,
                                                responseType: StudentDetail.self)
    }
    
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], CometClientError> {
        var httpBody: [String: Int] = [:]
        
        if let skills = student.skills {
            skills.forEach { skill in
                httpBody[skill.skillType.rawValue] = skill.value
            }
        }
        
        let request = RequestBuilder
            .createRequest(for: "http://emarest.cz.mass-php-1.mit.etn.cz/api/v2/participants/\(student.id)/skills?sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)",
                           with: .init(method: "POST",
                                      httpBody: try? JSONEncoder().encode(httpBody),
                                      headers: ["application/json": "Content-Type"],
                                      authentorized: false))
        
        return cometClient.performAuthenticatedRequest(request,
                                                       responseType: [StudentDetail.Skill].self)
    }
}

final class MockedStudentRepository: StudentRepositoryProtocol {
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], CometClientError> {
        Just(Mock.skills)
            .setFailureType(to: CometClientError.self)
            .eraseToAnyPublisher()
    }

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

    func fetchStudent(
        with id: String
    ) -> AnyPublisher<StudentDetail, CometClientError> {
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
}
