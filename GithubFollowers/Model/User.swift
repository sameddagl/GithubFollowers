//
//  User.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let avatarURL: String
    let htmlURL: String
    let name: String?
    let location: String?
    let blog: String?
    let bio, twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case name, location, blog, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
    }
    
}
