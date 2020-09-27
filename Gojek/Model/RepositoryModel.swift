//
//  RepositoryModel.swift
//  Gojek
//
//  Created by Neeraj Solanki on 25/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit

struct RepositoryModel : Decodable {
    var author : String?
    var name : String?
    var avatar : String?
    var url : String?
    var description : String?
    var stars : Int?
    var forks : Int?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case name = "name"
        case avatar = "avatar"
        case url = "url"
        case description = "description"
        case stars = "stars"
        case forks = "forks"
    }
    
    init() {
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        stars = try values.decodeIfPresent(Int.self, forKey: .stars)
        forks = try values.decodeIfPresent(Int.self, forKey: .forks)
    }

}
