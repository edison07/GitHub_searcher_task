//
//  Model.swift
//  GitHub_searcher_task
//
//  Created by edisonlin on 2022/3/6.
//

import Foundation

struct Model {
    let nextPath: String?
    let data: UserModel
}

struct UserModel: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [UserItemsModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct UserItemsModel: Codable {
    let avatarURL: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case name = "login"
    }
}
