//
//  AccountView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject private var accountViewModel: AccountViewModel = .init()
    
    @State private var showLoginPage: Bool = false
    @State private var edit: Bool = false
    
    var body: some View {
        if accountViewModel.loggedIn {
            StudentDetailView(studentId: accountViewModel.studentId, editable: true)
        } else {
            Button {
                self.showLoginPage = true
            } label: {
                Text("Login")
            }
            .sheet(isPresented: $showLoginPage) {
                LoginView(loggedIn: $accountViewModel.loggedIn)
            }
        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
