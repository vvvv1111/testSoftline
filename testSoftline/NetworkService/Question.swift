//
//  Question.swift
//  testSoftline
//
//  Created by Vladimir on 29.11.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import Foundation

struct Question: Codable {
    let items: [Item]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}


// MARK: - Item
struct Item: Codable {
    let tags: [String]
    let owner: Owner
    let isAnswered: Bool
    let viewCount, answerCount, score, lastActivityDate: Int
    let creationDate: Int
    let lastEditDate: Int?
    let questionID: Int
//    let contentLicense: String
    let link: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case questionID = "question_id"
//        case contentLicense = "content_license"
        case link, title
    }
}

// MARK: - Owner
struct Owner: Codable {
    let userType, displayName: String
    let reputation, userID: Int?
    let profileImage: String?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case displayName = "display_name"
        case reputation
        case userID = "user_id"
        case profileImage = "profile_image"
        case link
    }
}
