//
//  Follower.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import Foundation

struct Follower: Identifiable ,Codable, Hashable {
    var login: String
    var id: Int
    var avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
