//
//  MainTabViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine

class MainTabViewModel: ObservableObject {
    @Published var openTab: Int
    
    private let userDefaultsRepo: UserDefaultsRepository = .init()
    private var bag = Set<AnyCancellable>()
    
    init() {
        self.openTab = LoginRepository.tokenExists ? 1 : 2
    }
    
}
