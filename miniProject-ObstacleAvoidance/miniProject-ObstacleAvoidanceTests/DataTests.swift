//
//  DataTests.swift
//  miniProject-ObstacleAvoidanceTests
//
//  Created by Darien Aranda on 11/3/24.
//

import Testing

struct DataTests {
    
    @Test func testUserInit() async throws {
        //Testing the Initialization of creating a User instance
        //Creating instance of Commend using Testing
        let testUser = User(
            UserID: 1,
            Name: "Darien Aranda",
            Email: "Daranda@sandiego.edu",
            Password: "123456789",
            AdminStatus: true)
        
        //Setting up assertion statements
        #expect(testUser.UserID == 1)
        #expect(testUser.Name == "Darien Aranda")
        #expect(testUser.Email == "Daranda@sandiego.edu")
        #expect(testUser.Password == "123456789")
        #expect(testUser.AdminStatus == true)
    }
    
    @Test func testPostInit() async throws {
        //Testing the Initialization of creating a Post instance
        //Creating instance of Commend using Testing
        let testPost = Post(
            PostID: 1,
            UserID: 1,
            PostContent: "This is a sample of a posts content")

        //Setting up assertion statements
        #expect(testPost.PostID == 1)
        #expect(testPost.UserID == 1)
        #expect(testPost.PostContent == "This is a sample of a posts content")
    }
    
    @Test func testCommentInit() async throws {
        //testing the Initialization of creating a Comment Instance
        //Creating instance of Commend using Testing
        let testComment = Comment(
            CommentID: 1,
            UserID: 1,
            PostID: 1,
            CommentContent: "This is a sample of a comment content")

        //Setting up assertion statements
        #expect(testComment.CommentID == 1)
        #expect(testComment.UserID == 1)
        #expect(testComment.CommendContent = "This is a sample of a comment content")
    }
}
