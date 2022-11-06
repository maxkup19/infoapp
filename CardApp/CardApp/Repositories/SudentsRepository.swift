//
//  SudentsRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import Foundation
import Combine

class StudentRepository {
    
    static func fetchStudents() -> AnyPublisher<[StudentOverallInfo], Error> {
        
        let urlString = "http://emarest.cz.mass-php-1.mit.etn.cz/api/v1/participants?sort=asc&sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)"
        
        let request = URLRequest(url: URL(string: urlString)!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(\.data)
            .decode(type: [StudentOverallInfo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        
    }
    
    static func fetchStudent(by participantId: String) -> AnyPublisher<StudentFullInfo, Error> {
        
        let urlString = "http://emarest.cz.mass-php-1.mit.etn.cz/api/v1/participants/\(participantId)?sort=asc&sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)"
        
        let request = URLRequest(url: URL(string: urlString)!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(\.data)
            .decode(type: StudentFullInfo.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
