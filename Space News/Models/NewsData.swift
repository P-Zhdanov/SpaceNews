//
//  Model.swift
//  Spac News
//
//  Created by Павел Жданов on 23.04.2021.
//

import UIKit

struct NewsData: Codable {
    let id: String
    let title: String
    let url: String
    let imageURL: String
    let newsSite: NewsSite
    let summary: String
    let publishedAt: Date
    let updatedAt: String
    let featured: Bool
    let launches, events: [Event]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case imageURL = "imageUrl"
        case newsSite
        case summary
        case publishedAt
        case updatedAt
        case featured
        case launches
        case events
    }
}

struct Event: Codable {
    let id: String
    let provider: String
}

enum NewsSite: String, Codable {
    case arstechnica = "Arstechnica"
    case spaceflightNow = "Spaceflight Now"
}

extension Formatter {
    static let iso8601withFractionalSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withFractionalSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                  debugDescription: "Invalid date: " + string)
        }
        return date
    }
}
