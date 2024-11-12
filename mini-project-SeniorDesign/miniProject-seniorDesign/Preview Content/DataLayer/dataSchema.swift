//
//  DataSchema.swift
//  mini-project
//
//  Created by Darien Aranda on 11/4/24.
//

import Foundation
import SwiftData
import SwiftUI


//need to research if cascading is a default setup, or if we need a work around
@Model
final class User { //may need to make this Identifiable
    var name: String
    var email: String
    var admin: Bool
    
    // Revised One-to-many relationship to posts
    @Relationship(inverse: \Post.user) var posts: [Post] = []
    
    // Revised One-to-many relationship to comments
    @Relationship(inverse: \Comment.user) var comments: [Comment] = []

    init(name: String, email: String, admin: Bool) {
        self.name = name
        self.email = email
        self.admin = admin
    }
}

@Model
final class Post {
    var contents: String
    var createdAt: Date
    
    // Revised Many-to-one relationship to user
    var user: User
    
    // Revised One-to-many relationship to comments
    @Relationship(inverse: \Comment.post) var comments: [Comment] = []

    init(user: User, contents: String, createdAt: Date = Date()) {
        self.user = user
        self.contents = contents
        self.createdAt = createdAt
    }
}

@Model
final class Comment {
    var contents: String
    var createdAt: Date
    
    // Revised Many-to-one relationship to user
    var user: User
    
    // Revised Many-to-one relationship to post
    var post: Post

    init(user: User, post: Post, contents: String, createdAt: Date = Date()) {
        self.user = user
        self.post = post
        self.contents = contents
        self.createdAt = createdAt
    }
}
