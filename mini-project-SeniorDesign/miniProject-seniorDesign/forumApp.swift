//
//  miniProject_seniorDesignApp.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/7/24.
//

import SwiftUI
import SwiftData
@main
struct forumApp: App {
    // Declare login state upon opening
   // @State private var loginState: LoginState = .notLoggedIn
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            ContentView(loginState: loginState)
    
        }
        .modelContainer(for: [User.self,Post.self ,Comment.self])
    }
}
