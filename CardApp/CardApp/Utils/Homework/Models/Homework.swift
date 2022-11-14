//
//  Homework.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct Homework: Identifiable, Hashable, Codable {
    let id: Int
    let number: Int
    let state: State
}

extension Homework {
    enum State: String, Comparable, Hashable, Codable {
        case acceptance
        case review
        case push
        case comingSoon = "comingsoon"
        case ready
        
        static func < (lhs: State, rhs: State) -> Bool {
            return getIntValue(state: lhs) < getIntValue(state: rhs)
        }
        
        private static func getIntValue(state: State) -> Int {
            switch state {
            case .comingSoon:
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
}


