//
//  StudentListRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine
import Comet

final class StudentListRepository: StudentListRepositoryProtocol {
    private let cometClient: CometClient = CometClient(tokenProvider: TokenProvider(),
                                                       authenticatedRequestBuilder: AuthenticatedRequestBuilder(),
                                                       logConfiguration: LogConfiguration(logLevel: .full,
                                                                                          logger: { Swift.print($0) }))
    
    func fetchStudentList() -> AnyPublisher<[Student], StudentError> {
        let request = RequestBuilder
            .createRequest(for: "http://emarest.cz.mass-php-1.mit.etn.cz/api/v2/participants?sort=asc&sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)",
                           with: .init(method: "GET",
                                       httpBody: nil,
                                       headers: ["application/json": "Content-Type"],
                                       authentorized: false))
        
        return cometClient
            .performAuthenticatedRequest(request,
                                         responseType: [Student].self)
            .mapError { StudentError.replaceCometError($0) }
            .eraseToAnyPublisher()
        
    }
}
