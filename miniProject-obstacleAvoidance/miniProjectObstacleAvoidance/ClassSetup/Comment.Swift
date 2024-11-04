//
//  Comment.Swift
//  miniProject-ObstacleAvoidance
//
//  Created by Darien Aranda on 11/3/24.
//

import Foundation

public class Comment {
    var CommentID: Int
    var PostID: Int
    var UserID: Int
    var CommentContent: String
    
    init(CommentID: Int, PostID: Int, UserID: Int, PostContent: String) {
        self.CommentID = CommentID
        self.PostID = PostID
        self.UserID = UserID
        self.CommentContent = PostContent
    }
}
