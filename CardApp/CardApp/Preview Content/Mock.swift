//
//  Preview.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct Mock {
    
    static let redactedStudentDetail: StudentDetail = .init(id: "maxkup19", name: "Maksym Kupchenko", title: "max", platform: .iOS, slackURL: "slack://user?team=T02LPBD5RC3&id=U044SGWRQSU", icon512: "https://wiki.upol.cz/images/b/bc/UP_logo_horizont_cz.png", skills: skills, homework: homeworks)
    
    static let redactedStudent: Student = .init(id: "maxkup19", name: "Maksym Kupchenko",  platform: .iOS, title: "max", icon512: "https://wiki.upol.cz/images/b/bc/UP_logo_horizont_cz.png", homework: [Homework(id: 1, number: 1, state: .acceptance), Homework(id: 2, number: 2, state: .ready), Homework(id: 3, number: 3, state: .review), Homework(id: 4, number: 4, state: .push)])
    
    static let skills: [StudentDetail.Skill] = [.init(skillType: .ios, value: 1), .init(skillType: .swift, value: 1), .init(skillType: .android, value: 1)]
    
    private static let homeworks: [Homework] = [Homework(id: 1, number: 1, state: .acceptance), Homework(id: 2, number: 2, state: .ready), Homework(id: 3, number: 3, state: .review),
                                                Homework(id: 4, number: 4, state: .push), Homework(id: 5, number: 5, state: .comingSoon), Homework(id: 6, number: 6, state: .comingSoon)]
}
