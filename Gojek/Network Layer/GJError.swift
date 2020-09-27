//
//  GJError.swift
//  Gojek
//
//  Created by Neeraj Solanki on 27/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import Foundation
typealias GJErrorHandler = (GJError?) -> Void

struct GJError: Error {
    var localizedDescription: String
    init(_ localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }
}
