//
//  AccountView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 26.10.2022.
//

import SwiftUI

struct AccountView: View {
   
    @State private var showLoginPage: Bool = true
    
    var body: some View {
        Button {
            self.showLoginPage = true
        } label: {
            Text("Login")
        }
        .sheet(isPresented: $showLoginPage) {
            LoginView()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
