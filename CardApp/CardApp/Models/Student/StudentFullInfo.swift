//
//  StudentInfoModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 27.10.2022.
//

import Foundation

struct StudentFullInfo: Identifiable, Codable {
    let id: String
    
    let name: String
    let participantType: Platform
    let title: String
    let slackURL: String
    let icon512: String
    let icon192: String
    let icon72: String
    let skills: [Skill]
    let homework: [Homework]
}
