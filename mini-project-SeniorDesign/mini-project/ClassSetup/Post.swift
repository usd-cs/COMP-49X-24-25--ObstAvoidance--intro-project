//
//  Post.swift
//  mini-project
//
//  Created by Darien Aranda on 11/4/24.
//

import Foundation

public class Post {
    var PostID: Int
    var UserID: Int
    var PostContent: String
    
    init(PostID: Int, UserID: Int, PostContnent: String) {
        self.PostID = PostID
        self.UserID = UserID
        self.PostContent = PostContnent
    }
}
