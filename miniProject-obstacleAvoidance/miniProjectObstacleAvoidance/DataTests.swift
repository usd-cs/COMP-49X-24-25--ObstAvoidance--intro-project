//
//  DataTests.swift
//  miniProject-ObstacleAvoidanceTests
//
//  Created by Darien Aranda on 11/3/24.
//

import XCTest

final class DataTests: XCTestCase {
    
    func testUserInit() throws {
        //Testing the Initialization of creating a User instance
        //Creating instance of Commend using Testing
        let testUser = User(
            UserID: 1,
            Name: "Darien Aranda",
            Email: "Daranda@sandiego.edu",
            Password: "123456789",
            AdminStatus: true)
        
        //Setting up assertion statements
        XCTAssertEqual(testUser.UserID, 1)
        XCTAssertEqual(testUser.Name, "Darien Aranda")
        XCTAssertEqual(testUser.Email, "Daranda@sandiego.edu")
        XCTAssertEqual(testUser.Password, "123456789")
        XCTAssertTrue(testUser.AdminStatus, "true")
    }
    
    func testPostInit() throws {
        //Testing the Initialization of creating a Post instance
        //Creating instance of Commend using Testing
        let testPost = Post(
            PostID: 1,
            UserID: 1,
            PostContnent: "This is a sample of a posts content")

        //Setting up assertion statements
        XCTAssertEqual(testPost.PostID, 1)
        XCTAssertEqual(testPost.UserID, 1)
        XCTAssertEqual(testPost.PostContent, "This is a sample of a posts content")
    }
    
    func testCommentInit() throws {
        //testing the Initialization of creating a Comment Instance
        //Creating instance of Commend using Testing
        let testComment = Comment(
            CommentID: 1,
            PostID: 1,
            UserID: 3,
            PostContent: "This is a sample of a comment content")

        //Setting up assertion statements
        XCTAssertEqual(testComment.CommentID, 1)
        XCTAssertEqual(testComment.PostID, 1)
        XCTAssertEqual(testComment.UserID, 3)
        XCTAssertEqual(testComment.CommentContent, "This is a sample of a comment content")
    }
}
