//
//  DataSchema.swift
//  mini-project
//
//  Created by Darien Aranda on 11/4/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class User {
    var UserID: UUID = UUID()
    var Name: String
    var Email: String
    var Password: String
    var AdminStatus: Bool
    var Posts: [Post] = []  // Use Array<Post> instead of List<Post> for one-to-many relationship

    init(Name: String, Email: String, Password: String, AdminStatus: Bool) {
        self.Name = Name
        self.Email = Email
        self.Password = Password
        self.AdminStatus = AdminStatus
    }
}

@Model
class Post {
    var PostID: UUID = UUID()
    var UserID: User  // Links Post to User
    var PostContent: String
    var Comments: [Comment] = []  // Use Array<Comment> instead of List<Comment> for one-to-many relationship

    init(UserID: User, PostContent: String) {
        self.UserID = UserID
        self.PostContent = PostContent
    }
}

@Model
class Comment {
    var CommentID: UUID = UUID()
    var PostID: Post  // Links Comment to Post
    var CommentContent: String

    init(PostID: Post, CommentContent: String) {
        self.PostID = PostID
        self.CommentContent = CommentContent
    }
}
