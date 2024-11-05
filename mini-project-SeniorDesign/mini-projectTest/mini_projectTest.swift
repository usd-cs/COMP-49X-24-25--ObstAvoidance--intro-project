//
//  DataSchemaTests.swift
//  mini-projectTests
//
//  Created by Darien Aranda on 11/4/24.
//

import XCTest
import SwiftData
import SwiftUI



final class DataSchemaTests: XCTestCase {

    func testUserInitialization() {
        let user = User(Name: "Darien Aranda", Email: "daranda@sandiego.edu", Password: "securepassword", AdminStatus: true)

        XCTAssertNotNil(user.UserID)
        XCTAssertEqual(user.Name, "Darien Aranda")
        XCTAssertEqual(user.Email, "daranda@sandiego.edu")
        XCTAssertEqual(user.Password, "securepassword")
        XCTAssertTrue(user.AdminStatus)
        XCTAssertTrue(user.Posts.isEmpty)
    }

    func testPostInitialization() {
        let user = User(Name: "Sample User", Email: "user@example.com", Password: "password", AdminStatus: false)
        let post = Post(UserID: user, PostContent: "This is a sample post content.")

        XCTAssertNotNil(post.PostID)
        XCTAssertEqual(post.UserID, user)
        XCTAssertEqual(post.PostContent, "This is a sample post content.")
        XCTAssertTrue(post.Comments.isEmpty)
    }

    func testCommentInitialization() {
        let user = User(Name: "Sample User", Email: "user@example.com", Password: "password", AdminStatus: false)
        let post = Post(UserID: user, PostContent: "Sample post for comment testing.")
        let comment = Comment(PostID: post, CommentContent: "This is a sample comment content.")

        XCTAssertNotNil(comment.CommentID)
        XCTAssertEqual(comment.PostID, post)
        XCTAssertEqual(comment.CommentContent, "This is a sample comment content.")
    }

    func testAddingPostToUser() {
        let user = User(Name: "Sample User", Email: "user@example.com", Password: "password", AdminStatus: false)
        let post = Post(UserID: user, PostContent: "User's first post.")

        user.Posts.append(post)

        XCTAssertEqual(user.Posts.count, 1)
        XCTAssertEqual(user.Posts[0], post)
    }

    func testAddingCommentToPost() {
        let user = User(Name: "Sample User", Email: "user@example.com", Password: "password", AdminStatus: false)
        let post = Post(UserID: user, PostContent: "Sample post for comments.")
        let comment = Comment(PostID: post, CommentContent: "First comment on the post.")

        post.Comments.append(comment)

        XCTAssertEqual(post.Comments.count, 1)
        XCTAssertEqual(post.Comments[0], comment)
    }
}
