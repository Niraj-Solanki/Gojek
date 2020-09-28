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
    private var repositories:[RepositoryModel]?
    private var isApiRunning = false
    
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
             repositories = fetchDataFromStore()
            if let repositories = repositories, repositories.count > 0 {
                return repositories
            }
            else
            {
                forceUpdate()
            }
        }
        return []
    }
    
    var refreshTitle:NSAttributedString {
        return NSAttributedString(string: "Pull to refresh")
    }
    
    
    private func fetchDataFromStore() ->[RepositoryModel] {
        do {
            return try DataManager.shared.fetchRepositories()
        } catch  {
            print("Can't Fetch")
            return []
        }
    }
    
    private func saveDataInStore(repositories:[RepositoryModel]) {
        do {
            try DataManager.shared.insertRepositories(repositories: repositories)
        } catch  {
            print("Can't Store")
        }
    }
    
    func forceUpdate() {
        getTrendingRepositories()
    }
    
    //MARK:- API Work
   private func getTrendingRepositories() {
    if isApiRunning {
        return
    }
    
    HTTPClient.shared.dataTask(GitRepositories.trendingRepositories) { [weak self] (result) in
            self?.isApiRunning = false
        
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                guard let data = data else { self.observerBlock?(.dataFailed); return }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let repositoriesData = try jsonDecoder.decode([RepositoryModel].self, from: data)
                    self.repositories = repositoriesData
                    self.saveDataInStore(repositories: repositoriesData)
                    self.observerBlock?(.dataLoaded)
                } catch {
                    print(error.localizedDescription)
                    self.observerBlock?(.dataFailed)
                }
                
            case .failure( _):
                self.observerBlock?(.dataFailed)
            }
        }
    }
}
