//
//  ContentView.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/7/24.
//
import SwiftUI
import SwiftData
import Foundation



struct ContentView: View {
    @State private var isLoggedIn = true
    @State private var isAdmin = true
    @State private var showDeleteConfirmation = false
    @State private var postToDelete: Post? = nil
    @Environment(\.modelContext) private var context: ModelContext
    @Query var posts: [Post]
    @Query var loggedUsers: [User]
    @State private var newPostContent = ""
    @State private var isCreatingPost = false  // For triggering the new post  form
    @State private var currentUser: User? = nil
    @State private var refreshTrigger = false

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
                    NavigationLink(destination: NewPostView(context: context, loggedUsers: loggedUsers, currentUser: user, refreshTrigger: $refreshTrigger)) {
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

            .onAppear {
                            setupTestUser()  // Initialize the test user on appear
                            print("I have no clue")
                        }
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
            .onAppear{
                print("contentViw appear, posts reloaded")
            }

        }
    }
    private func setupTestUser() {
                let testUser = User(name: "Test User", email: "test@example.com", admin: false)
                context.insert(testUser)
                do {
                    try context.save()
                    currentUser = testUser
                } catch {
                    print("Failed to save test user: \(error)")
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
    

