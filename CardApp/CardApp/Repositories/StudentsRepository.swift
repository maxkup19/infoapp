//
//  SudentsRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import Foundation
import Combine

protocol StudentRepositoryProtocol {
    func fetchStudentList() -> AnyPublisher<[Student], NetworkManagerError>
    func fetchStudent(with id: String) -> AnyPublisher<StudentDetail, NetworkManagerError>
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], NetworkManagerError>
}

final class StudentRepository: StudentRepositoryProtocol {
    
    private let userDefaultsRepo: UserDefaultsRepository = .init()
    private let loginRepo: LoginRepository = .init()
    private var bag = Set<AnyCancellable>()
    
    func fetchStudentList() -> AnyPublisher<[Student], NetworkManagerError> {
        
        let payload: NetwokManagerPayload = .init(method: "GET",
                                                  httpBody: nil,
                                                  headers: ["application/json": "Content-Type"],
                                                  authentorized: true)
        
        let request =
        NetworkManager
            .performRequest(
                for: "http://emarest.cz.mass-php-1.mit.etn.cz/api/v2/participants?sort=asc&sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)",
                with: payload,
                responseType: [Student].self)
        
        return request
            .catch { error -> AnyPublisher<[Student], NetworkManagerError> in
                if case .decodingError(NetworkManagerError.authenticationError) = error {
                    return self.updateToken(for: request)
                }
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    func fetchStudent(with id: String) -> AnyPublisher<StudentDetail, NetworkManagerError> {
        let payload: NetwokManagerPayload = .init(method: "GET",
                                                  httpBody: nil,
                                                  headers: ["application/json": "Content-Type"],
                                                  authentorized: true)
        
        let request = NetworkManager
            .performRequest(
                for: "http://emarest.cz.mass-php-1.mit.etn.cz/api/v2/participants/\(id)?sort=asc&sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)",
                with: payload,
                responseType: StudentDetail.self)
        
        return request
            .catch { error -> AnyPublisher<StudentDetail, NetworkManagerError> in
                if case .decodingError(NetworkManagerError.authenticationError) = error {
                    return self.updateToken(for: request)
                }
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], NetworkManagerError> {
        
        var httpBody: [String: Int] = [:]
        
        if let skills = student.skills {
            skills.forEach { skill in
                httpBody[skill.skillType.rawValue] = skill.value
            }
        }
        
        let payload: NetwokManagerPayload = .init(method: "POST",
                                                  httpBody: try? JSONEncoder().encode(httpBody),
                                                  headers: ["application/json": "Content-Type"],
                                                  authentorized: true)
        
        let request = NetworkManager
            .performRequest(
                for: "http://emarest.cz.mass-php-1.mit.etn.cz/api/v2/participants/\(student.id)/skills?sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)",
                with: payload,
                responseType: [StudentDetail.Skill].self)
        
        return request
            .catch { error -> AnyPublisher<[StudentDetail.Skill], NetworkManagerError> in
                if case .decodingError(NetworkManagerError.authenticationError) = error {
                    
                    return self.updateToken(for: request)
                }
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func updateToken<ResponseObject: Codable> (for request: AnyPublisher<ResponseObject, NetworkManagerError>) -> AnyPublisher<ResponseObject, NetworkManagerError> {
        self.loginRepo.updateToken()
            .flatMap { loginResponse -> AnyPublisher<ResponseObject, NetworkManagerError> in
                self.userDefaultsRepo.save(accessToken: loginResponse.accessToken)
                self.userDefaultsRepo.save(expiration: loginResponse.expiration)
                
                return request
            }
            .eraseToAnyPublisher()
    }
}


final class MockedStudentRepository: StudentRepositoryProtocol {
    func updateSkills(for student: StudentDetail) -> AnyPublisher<[StudentDetail.Skill], NetworkManagerError> {
        Just(Mock.skills)
            .setFailureType(to: NetworkManagerError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchStudentList() -> AnyPublisher<[Student], NetworkManagerError> {
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
        .setFailureType(to: NetworkManagerError.self)
        .eraseToAnyPublisher()
    }
    
    func fetchStudent(
        with id: String
    ) -> AnyPublisher<StudentDetail, NetworkManagerError> {
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
        .setFailureType(to: NetworkManagerError.self)
        .eraseToAnyPublisher()
    }
}
