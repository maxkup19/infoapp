//
//  StudentListRepositoryProtocol.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine

protocol StudentListRepositoryProtocol {
    func fetchStudentList() -> AnyPublisher<[Student], StudentError>
}
