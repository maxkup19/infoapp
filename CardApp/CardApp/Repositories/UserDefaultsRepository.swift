//
//  UserDefaultsRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation

final class UserDefaultsRepository {
    
    private static let accessTokenKey: String = "com.maxkup19.CardApp.accessToken"
    private static let expirationKey: String = "com.maxkup19.CardApp.expiration"
    
    private let userDefaults = UserDefaults.standard
    
    func save(accessToken: String) {
        userDefaults.set(accessToken,
                         forKey: Self.accessTokenKey)
    }
    
    var accessToken: String? {
        userDefaults.string(forKey: Self.accessTokenKey)
    }
    
    func save(expiration: String) {
        userDefaults.set(expiration,
                         forKey: Self.expirationKey)
    }
    
    var expiration: String? {
        userDefaults.string(forKey: Self.expirationKey)
    }
    
    func clear() {
        userDefaults.set(nil, forKey: Self.expirationKey)
        userDefaults.set(nil, forKey: Self.accessTokenKey)
    }
}
