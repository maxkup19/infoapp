//
//  Preview.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import Foundation

struct Mock {
    static var student: Student = Student(name: "Maksym", surname: "Kupchenko", platform: .iOS, image: "maksym_kupchenko_ios",
                                          slackId: "U044SGWRQSU", email: "maxkup19@gmail.com",
                                          linkedInLink: "https://www.linkedin.com/in/maksym-kupchenko-999067207/",
                                          homeworks: [Homework(number: 1, status: .ready), Homework(number: 2, status: .accepted),
                                          Homework(number: 3, status: .reviewed), Homework(number: 4, status: .pushed),
                                          Homework(number: 5, status: .comingSoon), Homework(number: 6, status: .comingSoon)])
}
