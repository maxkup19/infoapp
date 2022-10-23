//
//  PlatformModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

enum Platform: String, CaseIterable, Identifiable {
    
    var id: UUID { UUID() }
    
    case all = "All"
    case iOS = "iOS"
    case android = "Android"
}
