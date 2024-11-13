//
//  commentView.swift
//  miniProject-seniorDesign
//
//  Created by Austin Lim on 11/12/24.
//

import SwiftUI

struct commentView: View{
    let comments: [Comment]
    
    var body : some View{
        List(comments, id: \.createdAt) { comment in
                    VStack(alignment: .leading) {
                        HStack{
                            VStack{
                                Text(comment.contents)
                                    .font(.body)
                            }
                        }
                        
                    }
                    .padding()
                }
                .navigationTitle("Comments")
  
    }
    
}
