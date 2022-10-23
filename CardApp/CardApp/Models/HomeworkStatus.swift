//
//  HomeworkStatus.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

enum HomeworkStatus: Int, CaseIterable, Comparable {
    static func < (lhs: HomeworkStatus, rhs: HomeworkStatus) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case comingSoon
    case pushed
    case reviewed
    case accepted
    case ready
}
