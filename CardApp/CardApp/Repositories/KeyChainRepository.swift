//
//  KeyChainRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine

final class KeyChainRepository {
    
    private static let usernameKey: String = "com.maxkup19.CardApp.usernameKey"
    private static let passwordServiceKey: String = "com.maxkup19.CardApp.keychain.password"
    private static let userIdServiceKey: String = "com.maxkup19.CardApp.keychain.userId"
    
    func store(password: String) {
        guard let password = password.data(using: .utf8) else { return }
        
        let query: [String: AnyObject] = [
            kSecAttrService as String: Self.passwordServiceKey as AnyObject,
            kSecAttrAccount as String: Self.usernameKey as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            
            kSecValueData as String: password as AnyObject
        ]
        
        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )
        
        guard status == errSecSuccess else {
            print("Unexpected error")
            return
        }
    }
    
    
    func readPassword() -> String? {
        let query: [String: AnyObject] = [
            
            kSecAttrService as String: Self.passwordServiceKey as AnyObject,
            kSecAttrAccount as String: Self.usernameKey as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            
            kSecReturnData as String: kCFBooleanTrue
        ]
        
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )
        
        guard status != errSecItemNotFound else {
            debugPrint("Record not found")
            return nil
        }
        
        guard status == errSecSuccess else {
            debugPrint("Unexpected status")
            return nil
        }
        
        guard let passwordData = itemCopy as? Data else {
            debugPrint("Invalid record format")
            return nil
        }
        
        let password = String(
            decoding: passwordData,
            as: UTF8.self
        )
        return password
    }
    
    func store(userId: String) {
        guard let userId = userId.data(using: .utf8) else { return }
        
        let query: [String: AnyObject] = [
            kSecAttrService as String: Self.userIdServiceKey as AnyObject,
            kSecAttrAccount as String: Self.usernameKey as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            
            kSecValueData as String: userId as AnyObject
        ]
        
        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )
        
        guard status == errSecSuccess else {
            return
        }
    }
    
    func readUserId() -> String? {
        let query: [String: AnyObject] = [
            
            kSecAttrService as String: Self.userIdServiceKey as AnyObject,
            kSecAttrAccount as String: Self.usernameKey as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            
            kSecReturnData as String: kCFBooleanTrue
        ]
        
        
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )
        
        guard status != errSecItemNotFound else {
            return nil
        }
        
        guard status == errSecSuccess else {
            return nil
        }
        
        guard let userIdData = itemCopy as? Data else {
            return nil
        }
        
        let userId = String(
            decoding: userIdData,
            as: UTF8.self
        )
        
        return userId
    }
    
    func clear() {
        
        let deleteUsername: [String: AnyObject] = [
            kSecAttrService as String: Self.userIdServiceKey as AnyObject,
            kSecAttrAccount as String: Self.usernameKey as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
        ]
        
        SecItemDelete(deleteUsername as CFDictionary)
        
        let deletePassword: [String: AnyObject] = [
            kSecAttrService as String: Self.passwordServiceKey as AnyObject,
            kSecAttrAccount as String: Self.usernameKey as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
        ]
        
        SecItemDelete(deletePassword as CFDictionary)
    }
}
