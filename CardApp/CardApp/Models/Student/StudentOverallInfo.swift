//
//  StudentModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct StudentOverallInfo: Identifiable, Codable {
    
    let id: String
    
    let name: String
    let participantType: Platform
    let title: String
    let icon512: String
    let icon192: String
    let icon72: String
    let homework: [Homework]
    
}
