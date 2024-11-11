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
    @State private var isAdmin = true
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
        NavigationView{
            VStack {
                //gets the list of posts as well as puts it in the order
                List(posts, id: \.createdAt) { post in
                    VStack(alignment: .leading){
                        Text(post.contents)
                            .font(.headline)
                        Text("Posted by: \(post.user.name)")
                            .font(.subheadline)
                        Text("Posted at: \(post.createdAt.formatted())")
                            .font(.subheadline)
                        
                        ForEach(post.comments, id: \.createdAt){ comment in
                            Text(comment.contents)
                                .font(.body)
                                .padding(.leading)
                        }
                        
                        if isLoggedIn{
                            //when the user is logged in they will see the comment button and can make a comment
                            NavigationLink(destination: newCommentView())
                            {
                                Text("Add a comment").font(.caption).foregroundColor(.blue)
                            }
// THIS IS ALL OLD CODE, I DID not want to delete it bc it helps see //thought process
//                                Button(action: {
//                                    selectedPost = post
//                                    showNewCommentForm.toggle()
//                                }){
//                                    Text("Add a comment")
//                                        .font(.caption)
//                                        .foregroundColor(.blue)
//                                }
//                                .sheet(isPresented: $showNewCommentForm)
//                                {
//                                    VStack
//                                    {
//                                        Text("Add a comment").font(.title2)
//                                        TextField("Enter comment", text: $newCommentString)
//                                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                                            .padding()
//                                        Button("Submit")
//                                        {
//
//                                        }
//
//                                    }
//                                }
                        }
                    }
                }
                if isLoggedIn{
                    NavigationLink(destination: NewPostView())
                    {
                        Text("Create New Post")
                    }
                    .bold()
                    .padding(.top)
                    //OLD LOG OUT OR LOG IN CODE. Feel free to delete but is simpler, so can help //see thought process
//                    Button(action: {
//                        logout()
//                    }) {
//                        Text("Logout")
//                            .font(.headline)
//                            .foregroundColor(.blue)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .cornerRadius(10)
//                    }
//                    
//                    
                }
//                if !isLoggedIn{
//                    NavigationLink(destination: LoginView())
//                    {
//                        Text("Login")
//                    }
//                    .bold()
//                    .padding(.top)
//                }
                
            }
            //This is whatt allows us to have to login and logout in the top corner
            .navigationTitle("Posts")
            .navigationBarItems(trailing: HStack {
                if !isLoggedIn {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                } else {
                    Button(action: {
                        logout()
                    }) {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
            })
        }
        .onAppear{
            setupMockData()
        }
    }
    func logout(){
        isLoggedIn = false
    }
}


#Preview {
    ContentView()
}

//    init(loginState: LoginState) {
//        self._loginState = State(initialValue: loginState)
//    }

//#Preview {
//    ContentView(loginState: .notLoggedIn)
//}

//            switch loginState {
//            case .notLoggedIn:
//                //LoginView(loginState: $loginState)
//                ForumView(loginState: $loginState)
//            case .userLoggedIn:
//                UserView(loginState: $loginState)
//            case .adminLoggedIn:
//                AdminView(loginState: $loginState)
//            }
//        }
//        .padding()
//    }
//}
