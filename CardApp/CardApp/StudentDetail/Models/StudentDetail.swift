//
//  StudentInfoModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 27.10.2022.
//

import Foundation

struct StudentDetail: Codable, Equatable {
    let id: String
    let name: String
    let title: String
    let platform: Platform
    let slackURL: String
    let icon512: String
    var skills: [Skill]?
    let homework: [Homework]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case platform = "participantType"
        case slackURL
        case icon512
        case skills
        case homework
    }
}

extension StudentDetail {
    struct Skill: Codable, Equatable, Hashable, Identifiable {
        var id: UUID { UUID() }
        
        let skillType: SkillType
        var value: Int
    }
}

extension StudentDetail.Skill {
    enum SkillType: String, Identifiable, Codable, Equatable, CaseIterable {
        var id: UUID { UUID() }
        
        case swift
        case ios
        case android
        case kotlin
    }
}

