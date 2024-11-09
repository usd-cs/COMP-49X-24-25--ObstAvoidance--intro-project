//
//  ContentView.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/7/24.
//

import SwiftUI

enum LoginState {
    case notLoggedIn
    case userLoggedIn
    case adminLoggedIn
}


struct ContentView: View {
    @Binding var loginState: LoginState
    
    var body: some View {
        VStack {
            switch loginState {
            case .notLoggedIn:
                loginView(loginState: $loginState)
            case .userLoggedIn:
                userView(loginState: $loginState)
            case .adminLoggedIn:
                adminView(loginState: $loginState)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
