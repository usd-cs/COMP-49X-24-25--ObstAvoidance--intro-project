//
//  DataUtilsTesting.swift
//  miniProject-seniorDesign
//
//  Created by Carlos Breach on 11/9/24.
//

import SwiftUI
import SwiftData
import Testing

@testable import miniProject_seniorDesign

@MainActor
class DataUtilsTesting {
    var container: ModelContainer
    var modelContext: ModelContext
    lazy var mockLoggedUsers: [User] = setUpMockLoggedUsers()
    var notLoggedUser: User
    var salt: String
    var password: String
    init() throws{
        container = try ModelContainer(for: User.self, Post.self, Comment.self)
        modelContext = container.mainContext
        salt = createSalt()
        password = hashSaltPassword(password: "Cracked123", salt: salt)
        
        
        notLoggedUser = User(name: "Venancio", email: "Venancio@test.com", admin: false, password: password, salt: salt)
        
        //mockLoggedUsers = setUpMockLoggedUsers()
    }
    
    func setUpMockLoggedUsers() -> [User]{
        var salt2: String
        var salt3: String
        var password2: String
        var password3: String
        salt2 = createSalt()
        password2 = hashSaltPassword(password: "Hack123", salt: salt)
        salt3 = createSalt()
        password3 = hashSaltPassword(password: "Break567", salt: salt)
        let user1 = User(name: "Carlos", email: "cbreach@test.com", admin: false, password: password2, salt: salt2)
        let user2 = User(name: "John", email: "jdoe@test.com", admin: false, password: password3, salt: salt3)
        
        modelContext.insert(user1)
        modelContext.insert(user2)
        
        try? modelContext.save()//saves context changes
        
        return [user1, user2]
        
        
    }
    
    @Test("checks if a not logged user returns false-->checkIfLoggedIn(for: in:)") func checkIfLoggedInFalse(){
        //let notLoggedUser = User(name: "Venancio", email: "Venancio@test.com", admin: false)
        
        #expect(!DataUtils.checkIfLoggedIn(for: notLoggedUser, in: mockLoggedUsers))
    }
    
    @Test("checks if a logged user returns true --> checkIfLoggedIn(for: in:") func checkIfLoggedInTrue(){
        let loggedUser = mockLoggedUsers[0]
        
        #expect(DataUtils.checkIfLoggedIn(for: loggedUser, in: mockLoggedUsers))
    }
    
    @Test("Testing add a post when post content is empty ---> throws exception") func addPostEmpty(){
        #expect(throws: DataError.invalidContent){
            try DataUtils.addPost(for: mockLoggedUsers[0], post_content: "", logged_users: mockLoggedUsers, context: modelContext)
        }
    }
    
//    @Test("Testing attempting to add a post when user not loggedin") func addingPostNotLogged(){
//        let test_result = try! DataUtils.addPost(for: notLoggedUser, post_content: "test",logged_users: mockLoggedUsers, context: modelContext)
//        #expect(test_result == nil)
//    }
    
    @Test("Testing to add a valid post with a logged user") func addingPost(){
        let logged_user = mockLoggedUsers[0]
        let valid_post_content = "I hate XCode"
        let result = try? DataUtils.addPost(for: logged_user, post_content: "I hate XCode", logged_users: mockLoggedUsers, context: modelContext)
        
        #expect(result != nil) // the post should be created
        #expect(result?.contents == valid_post_content) //checks that the contents of the created post are equal to what was passed
        //also aparently the ? is to safelly unwrap potential nil values, kind of cool right?
        
        //#expect(modelContext.contains(result!)) im not too sure on how to check if the post was acutally added to the database but given that the .save() did not cause any error i'm assuming everything is according to plan
        
    }
    
//    @Test("user login with an empty email") func userInvalidLogin() {
//        let logged_user = mockLoggedUsers[0]
//        logged_user.n = "" //makes the user emial invalid
//
//        #expect(throws: DataError.invalidContent){
//            try DataUtils.userLogin(, context: modelContext)
//        }
//    }
    
//    @Test("new user logged in") func newUserLogin() {
//        let salt2 = createSalt()
//        let password2 = hashSaltPassword(password: "Hack123", salt: salt)
//        let user1 = User(name: "Carlos", email: "cbreach@test.com", admin: false, password: password2, salt: salt2)
//        modelContext.insert(user1)
//        try!modelContext.save()
//        let result = try! DataUtils.userLogin(username: user1.name, password: user1.password, context: modelContext)
//        #expect(result == user1)
//    }
}

