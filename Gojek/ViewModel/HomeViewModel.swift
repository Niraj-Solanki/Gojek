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
    
    var nib:UINib{
     return UINib.init(nibName: "RepoTableCell", bundle: nil)
    }
    
    var reusableIdentifier:String{
        return "RepoTableCell"
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
    
    var refreshTitle:NSAttributedString {
        return NSAttributedString(string: "Pull to refresh")
    }
    
    
    func foorceUpdate() {
        repoAPI()
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
