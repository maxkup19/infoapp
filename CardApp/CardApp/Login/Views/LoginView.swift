//
//  LoginView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var loggedIn: Bool
    @ObservedObject private var loginViewModel = LoginViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var showError: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            loginArea
            
            closeButton
        }
        .alert("Login failed...", isPresented: self.$showError) {
            Button("Retry", role: .cancel) { }
        }
        .onReceive(loginViewModel.$state) { state in
            if state == .error {
                self.showError = true
            } else if state == .success {
                self.loggedIn = true
                dismiss()
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
        LoginView(loggedIn: .constant(true))
    }
}
