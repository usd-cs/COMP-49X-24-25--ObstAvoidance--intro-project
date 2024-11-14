//
//  miniProject_seniorDesignTests.swift
//  miniProject-seniorDesignTests
//
//  Created by Darien Aranda on 11/7/24.
//

import Testing
import SwiftUI
import SwiftData
@testable import miniProject_seniorDesign


@MainActor
struct DataSchemaTests {
    var user: User
    var post: Post
    var comment: miniProject_seniorDesign.Comment
    var container: ModelContainer
    var modelContext: ModelContext
    var salt: String
    var password: String

    init() throws {
        // Initialize the container with the schema
        container = try ModelContainer(for: User.self, Post.self, Comment.self)
        modelContext = container.mainContext
        salt = createSalt()
        password = hashSaltPassword(password: "Cracked123", salt: salt)

        // Initialize sample instances
        user = User(name: "Darien Aranda", email: "daranda@sandiego.edu", admin: true, password: password, salt: salt)
        post = Post(user: user, contents: "This is a sample post content.")
        comment = Comment(user: user, post: post, contents: "This is a sample comment content.")
        
        // Insert instances into the model context
        modelContext.insert(user)
        modelContext.insert(post)
        modelContext.insert(comment)
    }
    
    // Test to verify User initialization
    @Test func testUserInitialization() {
        #expect(user.name == "Darien Aranda")
        #expect(user.email == "daranda@sandiego.edu")
        #expect(user.admin == true)
        #expect(user.password == password)
        #expect(user.salt == salt)
    }
    
    // Test to verify Post initialization
    @Test func testPostInitialization() {
        #expect(post.user == user)
        #expect(post.contents == "This is a sample post content.")
        #expect(post.comments.isEmpty == false)  // Check that there are no comments initially
    }
    
    // Test to verify Comment initialization
    @Test func testCommentInitialization() {
        #expect(comment.post == post)
        #expect(comment.user == user)
        #expect(comment.contents == "This is a sample comment content.")
    }
    
    // Test to add a post to a user and verify
    @Test("Adding a post to user and verifying") func addingPostToUser() {
        user.posts.append(post)
        #expect(user.posts.count == 1)
        #expect(user.posts.first == post)
    }
    
    // Test to add a comment to a post and verify
    @Test func addingCommentToPost() {
        post.comments.append(comment)
        #expect(post.comments.count == 1)
        #expect(post.comments.first == comment)
    }
}
