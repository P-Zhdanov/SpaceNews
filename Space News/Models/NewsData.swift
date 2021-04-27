//
//  Model.swift
//  Spac News
//
//  Created by Павел Жданов on 23.04.2021.
//

import UIKit

struct NewsData: Codable {
    let id, title: String
    let url: String
    let imageURL: String
    let newsSite: NewsSite
    let summary, publishedAt, updatedAt: String
    let featured: Bool
    let launches, events: [Event]

    enum CodingKeys: String, CodingKey {
        case id, title, url
        case imageURL = "imageUrl"
        case newsSite, summary, publishedAt, updatedAt, featured, launches, events
    }
}

struct Event: Codable {
    let id, provider: String
}

enum NewsSite: String, Codable {
    case arstechnica = "Arstechnica"
    case spaceflightNow = "Spaceflight Now"
}

typealias News = [NewsData]
