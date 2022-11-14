//
//  TabView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct MainTabView: View {
    
    @ObservedObject private var mainTabViewModel: MainTabViewModel = .init()
    
    var body: some View {
        TabView(selection: $mainTabViewModel.openTab){
            StudentListView()
                .tabItem {
                    Label("Participants", systemImage: "person.3.fill")
                }
                .tag(1)
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(2)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
