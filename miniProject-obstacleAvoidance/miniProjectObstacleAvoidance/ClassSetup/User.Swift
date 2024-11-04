//
//  User.Swift
//  miniProject-ObstacleAvoidance
//
//  Created by Darien Aranda on 11/3/24.
//

import Foundation
import SwiftData

public class User {
    var UserID: Int
    var Name: String
    var Email: String
    var Password: String
    var AdminStatus: Bool
    
    init(UserID: Int, Name: String, Email: String, Password: String, AdminStatus: Bool) {
        self.UserID = UserID
        self.Name = Name
        self.Email = Email
        self.Password = Password
        self.AdminStatus = AdminStatus
    }
}
