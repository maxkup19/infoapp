//
//  LoginView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct LoginView<LoginVM: LoginViewModelProtocol> : View {
    
    @Binding var loggedIn: Bool
    @ObservedObject private var loginViewModel: LoginVM
    @Environment(\.dismiss) private var dismiss
    
    init(loginViewModel: LoginVM, loggedIn: Binding<Bool>) {
        self._loggedIn = loggedIn
        self.loginViewModel = loginViewModel
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            loginArea
            
            closeButton
        }
        .alert("Login failed...", isPresented: $loginViewModel.showError) {
            Button("Retry", role: .cancel) { }
        }
        .onChange(of: loginViewModel.state) { state in
            if state == .success {
                self.loggedIn = true
                dismiss()
            } else {
                loginViewModel.showError = true
            }
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "x.circle")
                .font(.title3)
                .padding()
        }
    }
    
    private var loginArea: some View {
        NavigationStack {
            VStack {
                VStack {
                    LoginRowView(prompt: "Username", data: $loginViewModel.userId)
                    LoginRowView(prompt: "Password", data: $loginViewModel.password, isPrivate: true)
                }
                
                Button {
                    loginViewModel.login()
                } label: {
                    Text("Login")
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.orange)
                )
                
            }
            .navigationTitle("Login")
            .frame(width: 250)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel(loginUseCase: LoginUseCase(loginRepo: LoginRepository())),
                  loggedIn: .constant(true))
    }
}
