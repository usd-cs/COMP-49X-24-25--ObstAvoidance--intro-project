//
//  miniProject_seniorDesignApp.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/7/24.
//

import SwiftUI
import SwiftData
@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self,Post.self ,Comment.self])
    }
}
