//
//  StudentProtocol.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 28.10.2022.
//

import Foundation

protocol Student: Encodable, Identifiable {
    var id: String { get }
    var name: String { get }
    var participantType: Platform { get }
    var title: String { get }
    var icon512: String { get }
    var icon192: String { get }
    var icon72: String { get }
    var homework: [Homework] { get }
}
