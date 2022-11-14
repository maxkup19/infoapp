//
//  AccountView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct AccountView<AccountVM: AccountViewModelProtocol>: View {
    
    @ObservedObject private var accountViewModel: AccountVM
    
    init(accountViewModel: AccountVM) {
        self.accountViewModel = accountViewModel
    }
    
    var body: some View {
        if accountViewModel.loggedIn {
            StudentDetailView(studentViewModel:
                                StudentDetailViewModel(studentId: accountViewModel.studentId,
                                                                       editable: true))
        } else {
            Button {
                accountViewModel.showLoginPage = true
            } label: {
                Text("Login")
            }
            .sheet(isPresented: $accountViewModel.showLoginPage) {
                LoginView(loginViewModel: LoginViewModel(), loggedIn: $accountViewModel.loggedIn)
            }
        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(accountViewModel: AccountViewModel())
    }
}
