//
//  AccountViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine

class AccountViewModel: ObservableObject {
    @Published var loggedIn: Bool
    
    private let keyChainRepo = KeyChainRepository()
    var studentId: String { self.keyChainRepo.readUserId() ?? "" }
    
    init() {
        self.loggedIn = LoginRepository.tokenExists
    }
}
