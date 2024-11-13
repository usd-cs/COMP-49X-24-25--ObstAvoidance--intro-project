//
//  commentView.swift
//  miniProject-seniorDesign
//
//  Created by Austin Lim on 11/12/24.
//

import SwiftUI

struct commentView: View{
    let comments: [Comment]
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
                        if isAdmin{
                            NavigationLink(destination: deletePostView()) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Remove button background padding
                            .frame(width: 14, height: 14)
                            .padding(.leading, 30)
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
  
    }
    
}
