//
//  ContentView.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/7/24.
//
import SwiftUI
import SwiftData

//enum LoginState {
//    case notLoggedIn
//    case userLoggedIn
//    case adminLoggedIn
//}

struct ContentView: View {
    
    //    @State var loginState: LoginState
    @State private var isLoggedIn = true
    @State private var isAdmin = false
    @State private var showNewPostForm = false
    @State private var showNewCommentForm = false
    @State private var newCommentString = ""
    @State private var selectedPost: Post?
    @State private var posts: [Post] = []
    // Function to set up mock data
    func setupMockData() {
        // Creating mock posts with contents and dates
        let user1 = User(name: "John Doe", email: "john@example.com", admin: true)
        let user2 = User(name: "Jane Smith", email: "jane@example.com", admin: false)
        let user3 = User(name: "Alice Brown", email: "alice@example.com", admin: false)
        
        // Create mock posts associated with these users
        let post1 = Post(user: user1, contents: "This is the first post", createdAt: Date())
        let post2 = Post(user: user2, contents: "This is the second post", createdAt: Date().addingTimeInterval(-3600))
        let post3 = Post(user: user3, contents: "This is the third post", createdAt: Date().addingTimeInterval(-7200))
        
        // Create mock comments associated with the posts and users
        let comment1 = Comment(user: user2, post: post1, contents: "This is a comment on the first post")
        let comment2 = Comment(user: user3, post: post1, contents: "Another comment on the first post")
        let comment3 = Comment(user: user1, post: post2, contents: "Comment on the second post")
        
        // Add comments to the respective posts' comments relationships
        post1.comments.append(comment1)
        post1.comments.append(comment2)
        post2.comments.append(comment3)
        
        // Assign posts to the posts array
        self.posts = [post1, post2, post3]
    }


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
                                NavigationLink(destination: deletePostView()) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle()) // Remove button background padding
                                .frame(width: 24, height: 24) // Adjust to fit icon size exactly
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
                
                if isLoggedIn {
                    NavigationLink(destination: NewPostView()) {
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
            .onAppear { setupMockData() }
        }
    }
    
    func logout() {
        isLoggedIn = false
    }
}
    
    
    #Preview {
        ContentView()
    }
    

