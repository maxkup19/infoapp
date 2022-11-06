//
//  TabView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct MainTabView: View {
    
    @State var isLoggedIn: Bool = true
    
    var body: some View {
        TabView{
            StudentListView()
                .tabItem {
                    Label("Participants", systemImage: "person.3.fill")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
