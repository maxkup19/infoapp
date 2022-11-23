//
//  TabView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct MainTabView<MainTabVM: MainTabViewModelProtocol>: View {
    
    @ObservedObject private var mainTabViewModel: MainTabVM
    
    init(mainTabViewModel: MainTabVM) {
        self.mainTabViewModel = mainTabViewModel
    }
    
    var body: some View {
        TabView(selection: $mainTabViewModel.openTab){
            StudentListView(studentListViewModel: StudentListViewModel(studentRepo: CometStudentRepository()))
                .tabItem {
                    Label("Participants", systemImage: "person.3.fill")
                }
                .tag(1)
            AccountView(accountViewModel: AccountViewModel())
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(2)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(mainTabViewModel: MainTabViewModel())
    }
}
