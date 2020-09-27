//
//  GitRepositories.swift
//  Gojek
//
//  Created by Neeraj Solanki on 27/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import Foundation

enum GitRepositories {
    case trendingRepositories
}

extension GitRepositories: RequestProtocol {
    //Set Base URL
    var baseURL: URL {
        guard let url = URL(string: Constants.Service.baseURL) else {
            fatalError("BaseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .trendingRepositories:
            return "repositories"
        }
    }
    
    //Returns HTTP Method for repositories APIs
    var httpMethod: HTTPMethod {
        switch self {
        case .trendingRepositories:
            return .get
        }
    }
    
    //Encode and Returns Encoded Data
    var httpBody: Data? {
        return nil
    }
    
    //Return Repositories APIs Specific Headers
    var headers: HTTPHeaders? {
        return nil
    }
}
