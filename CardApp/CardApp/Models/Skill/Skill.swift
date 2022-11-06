//
//  Skill.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 24.10.2022.
//

import Foundation

struct Skill: Codable, Hashable {
    let skillType: SkillType
    let value: Int
}
