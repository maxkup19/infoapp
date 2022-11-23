//
//  MainTabViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine

protocol MainTabViewModelProtocol: ObservableObject {
    var openTab: Int { get set }
}

class MainTabViewModel: MainTabViewModelProtocol {
    @Published var openTab: Int = 2
    
    private let userDefaultsRepo: UserDefaultsRepository = .init()
    private var bag = Set<AnyCancellable>()
}
