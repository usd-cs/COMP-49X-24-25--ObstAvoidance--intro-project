//
//  miniProject_seniorDesignApp.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/7/24.
//

import SwiftUI

@main
struct forumApp: App {
    // Declare login state upon opening
    @State private var loginState: LoginState = .notLogginIn
    
    var body: some Scene {
        WindowGroup {
            ContentView(loginState: $loginState)
        }
    }
}
