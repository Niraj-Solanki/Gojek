//
//  RepoCellViewModel.swift
//  Gojek
//
//  Created by Neeraj Solanki on 26/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit

class RepoCellViewModel {
    
    private var repositoryModel:RepositoryModel?
    
    init(model:RepositoryModel? = nil) {
        if let model = model {
            repositoryModel = model
        }
    }
    
    var name:String {
        return repositoryModel?.name ?? ""
    }
    
    var stars:String{
        return "\(repositoryModel?.stars ?? 0)"
    }
    
    var description:String{
        return repositoryModel?.description ?? ""
    }

}
