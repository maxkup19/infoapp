//
//  Homework.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct Homework: Identifiable, Codable {
    let id: Int
    let state: HomeworkStatus
    let number: Int
}

