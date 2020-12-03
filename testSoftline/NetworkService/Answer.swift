//
//  Answer.swift
//  testSoftline
//
//  Created by Vladimir on 02.12.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import Foundation

// MARK: - Answer
struct Answer: Codable {
    var items: [AnswerItem]
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
struct AnswerItem: Codable {
    let owner: Owner
    let isAccepted: Bool
    let score, lastActivityDate: Int
    let lastEditDate: Int?
    let creationDate, answerID, questionID: Int
    var contentLicense, body: String

    enum CodingKeys: String, CodingKey {
        case owner
        case isAccepted = "is_accepted"
        case score
        case lastActivityDate = "last_activity_date"
        case lastEditDate = "last_edit_date"
        case creationDate = "creation_date"
        case answerID = "answer_id"
        case questionID = "question_id"
        case contentLicense = "content_license"
        case body
    }
}

// MARK: - Owner
struct AnswerOwner: Codable {
    let reputation, userID: Int
    let userType: String
    let acceptRate: Int?
    let profileImage: String
    let displayName: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case acceptRate = "accept_rate"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
}
