//
//  ContentView.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/7/24.
//
import SwiftUI
import SwiftData
import Foundation

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
                List(posts, id: \.createdAt) { post in
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
                    NavigationLink(destination: NewPostView(loggedUsers: loggedUsers, currentUser: user, context: context)) {
                        Text("Create New Post")
                    }
                    .bold()
                    .padding(.top)
                }

            }
            .navigationTitle("Posts")
            .navigationBarItems(trailing: HStack {
                if !isLoggedIn {
                    NavigationLink(destination: LoginView()) {
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
                      //      setupTestUser()  // Initialize the test user on appear
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
        let testUser = User(name: "Test User", email: "test@example.com", admin: false)
        context.insert(testUser)
        let customDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let customDate2 = Calendar.current.date(byAdding: .day, value: -2, to: Date())!

        // Create a couple of posts for the test user
        let post1 = Post(user: testUser, contents: "This is the first post by Test User.", createdAt: customDate)
        let post2 = Post(user: testUser, contents: "This is another post by Test User.", createdAt: customDate2)
        
        // Insert posts into the context
        context.insert(post1)
        context.insert(post2)

        // Assign posts to the test user
        testUser.posts.append(post1)
        testUser.posts.append(post2)
        
        // Save the context
        do {
            try context.save()
            print("Test user and posts saved successfully: \(testUser.name)")
            
            // Optional: Print all users and their posts for verification
            printAllUsers(context: context)
            printAllPosts(context: context)
            
            currentUser = testUser
        } catch {
            print("Failed to save test user or posts: \(error)")
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
    

