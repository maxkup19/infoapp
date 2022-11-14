//
//  CardAppApp.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 09.10.2022.
//

import SwiftUI

@main
struct CardAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView(mainTabViewModel: MainTabViewModel())
            // MARK: ONLY FOR TESTING
            // to start from login
            // run app, cmd+ctrl+z(shake gesture) then restart app
                .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
                    UserDefaultsRepository().clear()
                    KeyChainRepository().clear()
                }
        }
    }
}
