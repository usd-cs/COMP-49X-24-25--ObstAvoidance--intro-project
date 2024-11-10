//
//  MP_SwiftTesting.swift
//  mini-project-SeniorDesign
//
//  Created by Carlos Breach on 11/5/24.
//
import Testing
import SwiftUI
import SwiftData

struct DataSchema{
    var user: User
    var post: Post
    var comment: Comment
    
    init () async throws {
        user = User(Name: "Darien Aranda", Email: "daranda@sandiego.edu", Password: "securepassword", AdminStatus: true)
        
        post = Post(UserID: user, PostContent: "This is a sample post content.")
        
        comment = Comment(PostID: post, CommentContent: "This is a sample comment content.")
        
    }
    /**
     We may need to make a deinit to flush out the test objects before every test
     */
//    deinit {
//        user.Posts.removeAll()
//        user.Posts.count = 0
//        
//        post.Comments.removeAll()
//        post.Comments.count = 0
//        
//    }
    @Test func testUserInitialization(){
    
        #expect(user.Name == "Darien Aranda")
        #expect(user.Email == "daranda@sandiego.edu")
        #expect(user.Password == "securepassword")
        #expect(user.AdminStatus == true)
    }
    
    @Test func testPostInitialization(){
        
        /**
         XCTAssertNotNil(post.PostID)
         XCTAssertEqual(post.UserID, user)
         XCTAssertEqual(post.PostContent, "This is a sample post content.")
         XCTAssertTrue(post.Comments.isEmpty)
         */
        
        #expect(post.PostID != nil)
        #expect(post.UserID == user)
        #expect(post.PostContent == "This is a sample post content.")
        #expect(post.Comments.isEmpty)
        
    }
    
    @Test func testCommentInitialization(){
        /**
         XCTAssertNotNil(comment.CommentID)
         XCTAssertEqual(comment.PostID, post)
         XCTAssertEqual(comment.CommentContent, "This is a sample comment content.")
         */
        
        #expect(comment.CommentID != nil)
        #expect(comment.PostID == post)
        #expect(comment.CommentContent == "This is a sample comment content.")
    }
    
    @Test func addingPostToUser(){
        
        
        /**
         XCTAssertEqual(user.Posts.count, 1)
         XCTAssertEqual(user.Posts[0], post)
         */
        user.Posts.append(post)
        #expect(user.Posts.count == 1)
        #expect(user.Posts.first == post)
    }
    
    @Test func addingCommentToPost(){
        
        /**
         XCTAssertEqual(post.Comments.count, 1)
         XCTAssertEqual(post.Comments[0], comment)
         */
        post.Comments.append(comment)
        #expect(post.Comments.count == 1)
        #expect(post.Comments.first == comment)
    }
  
         
}







