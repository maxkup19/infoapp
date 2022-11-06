//
//  HomeworkStatus.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

enum HomeworkStatus: String, CaseIterable, Comparable, Codable {
    
    case comingsoon
    case push
    case review
    case acceptance
    case ready
    
    static func < (lhs: HomeworkStatus, rhs: HomeworkStatus) -> Bool {
        return getIntValue(status: lhs) < getIntValue(status: rhs)
    }
    
    private static func getIntValue(status: HomeworkStatus) -> Int {
        switch status {
        case .comingsoon:
            return 1
        case .push:
            return 2
        case .review:
            return 3
        case .acceptance:
            return 4
        case .ready:
            return 5
        }
    }
}
