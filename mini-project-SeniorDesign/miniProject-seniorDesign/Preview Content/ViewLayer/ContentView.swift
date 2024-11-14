//
//  ContentView.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/7/24.
//
import SwiftUI
import SwiftData
import Foundation
import CryptoKit

//enum LoginState {
//    case notLoggedIn
//    case userLoggedIn
//    case adminLoggedIn
//var container: ModelContainer
//var modelContext: ModelContext
//modelContext = container.mainContext
//}

struct ContentView: View {
    
    //    @State var loginState: LoginState
//    @State private var isLoggedIn = true
//    @State private var isAdmin = true
//    @State private var showNewPostForm = false
//    @State private var showNewCommentForm = false
//    @State private var newCommentString = ""
//    @State private var selectedPost: Post?
//    @State private var posts: [Post] = []
//    @State private var showDeleteConfirmation = false
//    @State private var postToDelete: Post? = nil
    @State private var isLoggedIn = true
    @State private var isAdmin = true
    @State private var showDeleteConfirmation = false
    @State private var postToDelete: Post? = nil
    @Environment(\.modelContext) var context
    @Query var posts: [Post]
    @Query var loggedUsers: [User]
    @State private var newPostContent = ""
    @State private var isCreatingPost = false  // For triggering the new post  form
    @State private var currentUser: User? = nil
    @State private var refreshTrigger = false
  



    // Function to set up mock data


    var body: some View {

        NavigationView {
            VStack {
                List(posts.sorted(by: { $0.createdAt > $1.createdAt }), id: \.createdAt) { post in
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(post.contents)
                                    .font(.headline)
                                
                                Text("Posted by: \(post.user.name)")
                                    .font(.subheadline)
                                
                                Text("Posted at: \(post.createdAt.formatted())")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            if isAdmin {
                                Button(action: {
                                    postToDelete = post // Store the post to delete
                                    showDeleteConfirmation = true 
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .frame(width: 24, height: 20)
                            }


                        }
                        
                        NavigationLink(destination: commentView(comments: post.comments, isAdmin: isAdmin, isLoggedIn: isLoggedIn)) {
                                Text("View all comments")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                                    .padding(.top, 5)
                        }
                        
                    }
                    .padding()
                }
                .id(refreshTrigger)
                if isLoggedIn, let user = currentUser {
                 //   print("Current user \(currentUser ?? default none)")
                    NavigationLink(destination: NewPostView(loggedUsers: loggedUsers, currentUser: user, context: context, refreshTrigger: $refreshTrigger)) {
                        Text("Create New Post")
                    }
                    .bold()
                    .padding(.top)
                }

            }
            .navigationTitle("Posts")
            .navigationBarItems(trailing: HStack {
                if !isLoggedIn {
                    NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn, currentUser: $currentUser,context: context)) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                } else {
                    Button(action: { logout() }) {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
            })
   //         .onAppear { setupMockData() }

            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("Do you really want to delete this post? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        if let post = postToDelete {
                            deletePost(post)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
       //                     setupTestUser()  // Initialize the test user on appear
                            print("User Set up")
//                DataUtils.printAllUsers(context: context)
//                DataUtils.printAllPosts(context: context)
//                DataUtils.printAllComments(context: context)
                        }
            .onAppear {
                            // Print all data when the view appears

                        }
//            .onAppear{
//                print("contentViw appear, posts reloaded")
//            }

        }
        
    }
    private func setupTestUser() {
        // Helper function to create a user with salted and hashed password
        func createUser(name: String, email: String, plainPassword: String, admin: Bool) -> User {
            let salt = createSalt()
            let encryptedPassword = hashSaltPassword(password: plainPassword, salt: salt)
            let user = User(name: name, email: email, admin: admin, password: encryptedPassword, salt: salt)
            context.insert(user)
            return user
        }
        
        // Helper function to create a post for a user
        func createPost(for user: User, contents: String, daysAgo: Int) -> Post {
            let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date())!
            let post = Post(user: user, contents: contents, createdAt: date)
            context.insert(post)
            return post
        }
        
        // Helper function to create a comment for a post
        func createComment(for post: Post, by user: User, contents: String, daysAgo: Int) -> Comment {
            let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date())!
            let comment = Comment(user: user, post: post, contents: contents, createdAt: date)
            context.insert(comment)
            return comment
        }
        
        // Create users with different passwords
        let user1 = createUser(name: "Alice", email: "alice@example.com", plainPassword: "alicePass123", admin: false)
        let user2 = createUser(name: "Bob", email: "bob@example.com", plainPassword: "bobSecret456", admin: false)
        let user3 = createUser(name: "Charlie", email: "charlie@example.com", plainPassword: "charlie789", admin: true)
        
        // Create posts for each user
        let post1User1 = createPost(for: user1, contents: "Alice's first post about Swift.", daysAgo: 1)
        let post2User1 = createPost(for: user1, contents: "Alice's thoughts on SwiftUI.", daysAgo: 3)
        
        let post1User2 = createPost(for: user2, contents: "Bob's insights on Core Data.", daysAgo: 2)
        let post2User2 = createPost(for: user2, contents: "Bob shares his experience with Combine.", daysAgo: 4)
        
        let post1User3 = createPost(for: user3, contents: "Charlie's admin perspective on iOS development.", daysAgo: 1)
        
        // Create comments for posts
        _ = createComment(for: post1User1, by: user2, contents: "Great insights, Alice!", daysAgo: 1)
        _ = createComment(for: post2User1, by: user3, contents: "Thanks for sharing, Alice.", daysAgo: 2)
        
        _ = createComment(for: post1User2, by: user1, contents: "Interesting points, Bob!", daysAgo: 1)
        _ = createComment(for: post2User2, by: user3, contents: "Nice breakdown!", daysAgo: 3)
        
        _ = createComment(for: post1User3, by: user1, contents: "Thanks, Charlie! Very helpful.", daysAgo: 1)
        _ = createComment(for: post1User3, by: user2, contents: "I appreciate the tips, Charlie.", daysAgo: 1)
        
        // Save the context
        do {
            try context.save()
            print("Test users, posts, and comments saved successfully.")
            
            // Optional: Print all users, posts, and comments for verification
            printAllUsers(context: context)
            printAllPosts(context: context)
            printAllComments(context: context)
            
            // Optionally, set the current user for testing
            currentUser = user1
        } catch {
            print("Failed to save test users, posts, or comments: \(error)")
        }
    }
    func logout() {
        isLoggedIn = false
    }
}
    
func deletePost(_ post: Post) {
    print("Post Delete Clicked")
}


    
    #Preview {
        ContentView()
    }
    

