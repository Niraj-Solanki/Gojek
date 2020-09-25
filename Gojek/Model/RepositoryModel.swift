//
//  RepositoryModel.swift
//  Gojek
//
//  Created by Neeraj Solanki on 25/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit

struct RepositoryModel : Decodable {
    let author : String?
    let name : String?
    let avatar : String?
    let url : String?
    let description : String?
    let language : String?
    let languageColor : String?
    let stars : Int?
    let forks : Int?
    let currentPeriodStars : Int?
    let builtBy : [BuiltBy]?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case name = "name"
        case avatar = "avatar"
        case url = "url"
        case description = "description"
        case language = "language"
        case languageColor = "languageColor"
        case stars = "stars"
        case forks = "forks"
        case currentPeriodStars = "currentPeriodStars"
        case builtBy = "builtBy"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        languageColor = try values.decodeIfPresent(String.self, forKey: .languageColor)
        stars = try values.decodeIfPresent(Int.self, forKey: .stars)
        forks = try values.decodeIfPresent(Int.self, forKey: .forks)
        currentPeriodStars = try values.decodeIfPresent(Int.self, forKey: .currentPeriodStars)
        builtBy = try values.decodeIfPresent([BuiltBy].self, forKey: .builtBy)
    }

}

struct BuiltBy : Codable {
    let username : String?
    let href : String?
    let avatar : String?

    enum CodingKeys: String, CodingKey {

        case username = "username"
        case href = "href"
        case avatar = "avatar"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        href = try values.decodeIfPresent(String.self, forKey: .href)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
    }

}
