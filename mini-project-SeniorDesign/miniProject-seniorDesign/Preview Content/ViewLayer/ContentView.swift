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
    @State var loginState: LoginState


    init(loginState: LoginState) {
        self._loginState = State(initialValue: loginState)
    }
    
    var body: some View {
        VStack {
            switch loginState {
            case .notLoggedIn:
                LoginView(loginState: $loginState)
            case .userLoggedIn:
                UserView(loginState: $loginState)
            case .adminLoggedIn:
                AdminView(loginState: $loginState)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(loginState: .notLoggedIn)
}
