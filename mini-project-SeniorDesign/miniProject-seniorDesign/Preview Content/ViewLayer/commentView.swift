//
//  commentView.swift
//  miniProject-seniorDesign
//
//  Created by Austin Lim on 11/12/24.
//

import SwiftUI

struct commentView: View{
    @State var commentToDelete: Comment?
    @State var showDeleteConfirmation: Bool = false
    
    @State var comments: [Comment]
    let isAdmin: Bool
    let isLoggedIn: Bool
    
    var body : some View{
        VStack{
            List(comments, id: \.createdAt) { comment in
                
                
                
                VStack(alignment: .leading) {
                    HStack{
                        VStack{
                            Text(comment.contents)
                                .font(.body)
                        }
                        if isAdmin {
                            Button(action: {
                                commentToDelete = comment
                                showDeleteConfirmation = true
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .frame(width: 24, height: 20)
                        }
                    }
                    
                    
                }
                .padding()
                
            }
            .navigationTitle("Comments")
            
            if isLoggedIn || isAdmin {
                NavigationLink(destination: newCommentView()) {
                    Text("Add a comment")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Do you really want to delete this comment? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    if let comment = commentToDelete {
                        deleteComment(comment)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    func deleteComment(_ comment: Comment) {
        comments.removeAll { $0.createdAt == comment.createdAt }
        print("Comment deleted: \(comment.contents)")
    }
}
