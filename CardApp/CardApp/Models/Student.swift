//
//  StudentModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct Student: Identifiable {
    
    let id: UUID = UUID()
    
    let name: String
    let surname: String
    let platform: Platform
    let image: String
    let slackId: String
    let email: String
    var linkedInLink: String?
    
    var homeworks: [Homework] = Homework.generateHomeworks(number: 6)
    
    var fullName: String {
        "\(name) \(surname)"
    }
    
}
