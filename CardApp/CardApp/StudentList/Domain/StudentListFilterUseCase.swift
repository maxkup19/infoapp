//
//  StudentListFilterUseCase.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation


protocol StudentListFilterUseCaseProtocol {
    func filter(students: [Student], by filter: Platform) -> [Student]
}

final class StudentListFilterUseCase: StudentListFilterUseCaseProtocol {
    func filter(students: [Student], by filter: Platform) -> [Student] {
        students.filter { $0.platform == filter || filter == .all }
    }
}
