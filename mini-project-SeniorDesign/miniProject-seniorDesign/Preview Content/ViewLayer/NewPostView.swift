//
//  NewPostView.swift
//  miniProject-seniorDesign
//
//  Created by Jacob Fernandez on 11/10/24.
//

import SwiftUI
import SwiftData
import Foundation

//
struct NewPostView: View {
    @State private var postContent: String = ""
    @State private var errorMessage: String? = nil
//    @Environment(\.modelContext) var context
//    @Environment(\.dismiss) var dismiss
    var loggedUsers: [User]
    var currentUser: User
    var context: ModelContext
    //@Binding var refreshTrigger: Bool
    var body: some View {
        VStack
        {
            Text("Add a new post").font(.title2)
            TextField("Enter a post", text: $postContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                submitPost()
            }) {
                Text("Post")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    func submitPost(){
        //Actions for the button added here
        do {
            if let newPost = try addPost(for: currentUser, post_content: postContent, logged_users: loggedUsers, context: context) {
                // If post is successfully created, show success message and clear content
                errorMessage = nil
                print("New post created: \(newPost.contents)")
                postContent = "" // Clear the post content
                try context.save()
     //           refreshTrigger.toggle()
 //               dismiss()
            } else {
                errorMessage = "Failed to create post. User might not be logged in."
            }
         } catch DataError.invalidContent {
             errorMessage = "Error: Post content is invalid."
         } catch DataError.couldNotSave {
             errorMessage = "Error: Post could not be saved to the database."
         }
            catch {
             errorMessage = "Unexpected error: \(error.localizedDescription)"
         }
     }

    
    
}
//#Preview {
//    NewPostView(loggedUsers: [User(name: "Test User", email: "user@example.com", admin: false)], currentUser: User(name: "Test User", email: "user@example.com", admin: false))
//}
#Preview {
    ContentView()
}
