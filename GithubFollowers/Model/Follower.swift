//
//  Follower.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
