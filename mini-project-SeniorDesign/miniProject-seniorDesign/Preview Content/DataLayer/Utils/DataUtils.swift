//
//  DataUtils.swift
//  miniProject-seniorDesign
//
//  Created by Carlos Breach on 11/8/24.
//

import Foundation
import SwiftData
import SwiftUI

enum DataError: Error {
    case invalidContent
    case couldNotSave
    case couldNotLoginUser
}

    /**
    im really not sure on whether or not @Envirorment and @Query should go here or if i'd be better off passing them as parameters to the functions
     */
   // @Environment(\.modelContext) static var context: ModelContext
    //@Query() static var logged_users: [User]
    
    
    /// checks if the passed user is whithin the databaser of users  --> @query can be set up to return an array of all the logged users in the database
    /// - Parameter user: the user to be checked whether or not is in the database
    /// - Parameter logged_users: the array containing all of the users currently in the database
    ///
    ///- Returns: true if the user is found in the array --> (in DB), false otherwhise
    func checkIfLoggedIn(for user :User, in logged_users: [User])->Bool{
        //im still not to sure on how to do this, but
        /**
         if user is logged in --> return true
         else -->return false
         */
        
        //i really hope that the email is unique in the database... else this apporach won't work
        let found_user = logged_users.first(where: { $0.email == user.email })
        
        //so, found_user should be nil if the user is not in the array aka, its not logged in
        
        if(found_user != nil){
            return true
        }
        
        
        return false
    }
    
    /// adds a post to the post database
    /// - Parameter commenting_user: the user to whom the post will be associated to
    /// - Parameter post_content: the content of the post
    /// - Parameter context: the context whithin all the database updates will be performed before being saved
    /// - Parameter logged_users: the list of users currently logged in, fetched from the database using @Query in the view part of the program
    ///
    /// - Throws: the function will throw an error if post_content is empty or if the Post failed to be saved to DB from context
    ///
    /// - Returns: Post the post added to the database if operation was succesfull or nil otherwise
func addPost(for commenting_user: User, post_content: String, logged_users: [User], context: ModelContext) throws -> Post?{
        
        //we probably don't want to add any empty posts
        guard !post_content.isEmpty else { throw DataError.invalidContent }
        print(commenting_user.name, logged_users)
        
        
//        if(checkIfLoggedIn(for: commenting_user, in: logged_users)){
           
            let new_post = Post(user: commenting_user , contents: post_content)
            
            commenting_user.posts.append(new_post) //we may not even need this line
            
            context.insert(new_post) //we insert the post into the context
            
            /**
             lastly based on what i understand the new post is currently stored in the context but is not saved permanently yet, so we have to do a try save
             
             **/
            
            do{
                try context.save()
                print("Printing inside of data utils: ")
                printAllUsers(context: context)
                printAllPosts(context: context)
                printAllComments(context: context)
                return new_post //if post is succesfully created we return the post to indicate this
            }
            catch{
                print("error post could not be saved to database")
                throw DataError.couldNotSave
            }
        

            
            
            
//        }
//        else{
//            // if user not found we return null so we prompt to login later in the program
//            return nil
//        }
        
        
    }
    
    
    ///Saves the given user to the database
    ///- Parameter user_to_login: the user to be added to database
    ///- Parameter context: the context where all database modifications will be done before saving
    ///
    ///- Throws function throws an error if saving new user in database fails or if the user in question has no emial (unique identifier)
    ///
    ///- Returns void
    func userLogin(for user_to_login: User, context: ModelContext) throws -> Bool?{
        
        //fist we check if the user object being passed has an email
        guard !user_to_login.email.isEmpty else{throw DataError.invalidContent}
        
        
        context.insert(user_to_login) //insert the user into the context layer
        
        do{
            try context.save()
            return true
        }
        catch{
            print("error saving user")
            throw DataError.couldNotLoginUser
        }
        
        
    }

        func printAllComments(context: ModelContext) {
            let fetchRequest = FetchDescriptor<Comment>() // Create a fetch descriptor for Comment
            do {
                let comments: [Comment] = try context.fetch(fetchRequest) // Fetch all comments
                print("Comments in Database:")
                for comment in comments {
                    print("Contents: \(comment.contents), Created At: \(comment.createdAt), Commented By: \(comment.user.name), On Post: \(comment.post.contents)")
                }
            } catch {
                print("Failed to fetch comments: \(error.localizedDescription)")
            }
        }
