//
//  LoginView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            loginArea
            
            closeButton
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
                    LoginRowView(prompt: "Username", data: $username)
                    LoginRowView(prompt: "Password", data: $password, isPrivate: true)
                }
                
                Button {
                    print("User logged in")
                    dismiss()
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
        LoginView()
    }
}
