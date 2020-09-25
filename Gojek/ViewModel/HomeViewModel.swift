//
//  HomeViewModel.swift
//  Gojek
//
//  Created by Neeraj Solanki on 26/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit
class HomeViewModel : NSObject{
    
    var observerBlock:((_ observerType:ObserverTypeEnum)->Void)?
    private var repositories:[RepositoryModel]? {
        didSet{
            observerBlock?(.dataLoaded)
        }
    }
    
    var items:[RepositoryModel]{
        if let repositories = repositories {
            return repositories
        }
        else
        {
            // Fetch from CoreData
            repoAPI()
        }
        
        return []
    }
    
    //MARK:- API Work
    func repoAPI() {
        let urlString = "https://ghapi.huchen.dev/repositories"
        if let url = URL.init(string: urlString) {
            observerBlock?(.dataLoading)
            let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data else { self.observerBlock?(.dataFailed); return }
                
                let jsonDecoder = JSONDecoder()
                do {
                    self.repositories = try jsonDecoder.decode([RepositoryModel].self, from: data)
                } catch {
                    print(error.localizedDescription)
                    self.observerBlock?(.dataFailed)
                }
            }
            downloadTask.resume()
        }
    }
}
