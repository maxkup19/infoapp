//
//  PlatformModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

enum Platform: String, CaseIterable, Identifiable, Codable {
    
    var id: UUID { UUID() }
    
    case all = "All"
    case iOS = "iosStudent"
    case android = "androidStudent"
    
    public var localized: String {
        switch self {
        case .all:
            return "All"
        case .android:
            return "Android"
        case .iOS:
            return "iOS"
        }
    }
    
}
