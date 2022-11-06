//
//  Preview.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct Mock {
    
    static let redactedStudentFull: StudentFullInfo = StudentFullInfo(id: "maxkup19", name: "Maksym Kupchenko", participantType: .iOS, title: "max", slackURL: "slack://user?team=T02LPBD5RC3&id=U044SGWRQSU", icon512: "maksym_kupchenko_ios", icon192: "maksym_kupchenko_ios", icon72: "maksym_kupchenko_ios", skills: skills, homework: homeworks)
    
    static let redactedStudentOverall: StudentOverallInfo = StudentOverallInfo(id: "maxkup19", name: "Maksym Kupchenko",  participantType: .iOS, title: "max", icon512: "maksym_kupchenko_ios", icon192: "maksym_kupchenko_ios", icon72: "maksym_kupchenko_ios", homework: [Homework(id: 1, state: .acceptance, number: 1), Homework(id: 2, state: .ready, number: 2), Homework(id: 3, state: .review, number: 3), Homework(id: 4, state: .push, number: 4)])
    
    private static let skills: [Skill] = [Skill(skillType: .ios, value: 1), Skill(skillType: .swift, value: 1), Skill(skillType: .android, value: 1), Skill(skillType: .kotlin, value: 1)]
    
    private static let homeworks: [Homework] = [Homework(id: 1, state: .acceptance, number: 1), Homework(id: 2, state: .ready, number: 2), Homework(id: 3, state: .review, number: 3),
                                                Homework(id: 4, state: .push, number: 4), Homework(id: 5, state: .comingsoon, number: 5), Homework(id: 6, state: .comingsoon, number: 6)]
}
