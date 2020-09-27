//
//  ServerError.swift
//  Gojek
//
//  Created by Neeraj Solanki on 27/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import Foundation
struct ServerError: Decodable {
    let status: String?
    let error: String?
}
