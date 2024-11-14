//
//  newCommentView.swift
//  miniProject-seniorDesign
//
//  Created by Jacob Fernandez on 11/11/24.
//
import SwiftUI

struct newCommentView: View{
    @State private var newCommentString = ""
    @Environment(\.modelContext) var context
    
    let selectedPost: Post
    let currentUser: User
    @Binding var comments: [Comment]
    
    var body: some View{
        VStack{
            Text("Add a comment").font(.title2)
            TextField("Enter a comment", text: $newCommentString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            Button(action: {
                addComment()
            }){
                Text("Post")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
            
        }
    }
    func addComment(){
        do{
            let comment = try DataUtils.addComment(for: context, post: selectedPost, user: currentUser, contents: newCommentString)
            newCommentString = ""
            comments.append(comment)
            
            
        }catch{
            print("Failed to add post: \(error)")
        }
    }
    
    
    
}

#Preview {
    ContentView()
}

