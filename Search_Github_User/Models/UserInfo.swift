//
//  User.swift
//  Search_Github_User
//
//  Created by Subhankar Ghosh on 17/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    var items: [UserBasicInfo]
    var totalCount: Int
    
    enum CodingKeys:String, CodingKey {
        case items
        case totalCount = "total_count"
    }
}

struct UserBasicInfo: Decodable {
    var avatarURL: String
    var userName: String
    var repositoriesURL: String?
//    var noOfRepositories: Int?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case userName = "login"
        case repositoriesURL = "repos_url"
//        case noOfRepositories = ""
    }
}

struct UserDetailInfo {
    var avatarURL: String
    var userName: String
    var noOfFollowers: String?
    var noOfFollowing: String?
    var biography: String?
    var email: String?
    var location: String?
    var joinDate: String?
    var repos: [UserRepository]?
}

struct UserRepository {
    var name: String
    var noOfStars: Int
    var noOfForks: Int
}
