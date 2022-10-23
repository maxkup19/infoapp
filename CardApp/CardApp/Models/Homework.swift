//
//  Homework.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct Homework: Identifiable {
    let id: UUID = UUID()
    
    let number: Int
    var status: HomeworkStatus
    
    public static func generateHomeworks(number: Int) -> [Homework] {
        var homeworks = [Homework]()
        
        for i in 1...6 {
            homeworks.append(Homework(number: i, status: HomeworkStatus.allCases.randomElement() ?? .comingSoon))
        }
        
        return homeworks
    }
    
}

