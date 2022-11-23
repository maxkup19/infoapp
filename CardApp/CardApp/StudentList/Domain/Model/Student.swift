//
//  StudentModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct Student: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let platform: Platform
    let title: String
    let icon512: String
    let homework: [Homework]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case platform = "participantType"
        case title
        case icon512
        case homework
    }
}

