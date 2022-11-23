//
//  StudentDetailRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine
import Comet

final class StudentDetailRepository: StudentDetailRepositoryProtocol {
    private let cometClient: CometClient = CometClient(tokenProvider: TokenProvider(),
                                                       authenticatedRequestBuilder: AuthenticatedRequestBuilder(),
                                                       logConfiguration: LogConfiguration(logLevel: .full,
                                                                                          logger: { Swift.print($0) }))
    
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
