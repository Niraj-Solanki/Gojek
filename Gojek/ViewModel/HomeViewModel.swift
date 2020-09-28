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
    private var repositories:[RepositoryModel] = []{
        didSet{
            observerBlock?(.dataLoaded)
        }
    }
    
    private var isApiRunning = false
    private let loaderAlert = UIAlertController(title: nil, message: "Fetching Data...", preferredStyle: .alert)
    
    override init() {
        super.init()
        self.initializeLoader()
        
        //Fetch Data From Store
        let repositoriesFromStore:[RepositoryModel] = fetchDataFromStore()
        if repositoriesFromStore.count > 0 {
            repositories = repositoriesFromStore
        }
        else
        {
            forceUpdate()
        }
    }
    
    var nib:UINib{
        return UINib.init(nibName: "RepoTableCell", bundle: nil)
    }
    
    var reusableIdentifier:String{
        return "RepoTableCell"
    }
    
    var items:[RepositoryModel] {
        return repositories
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
    
   private func initializeLoader() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
               loadingIndicator.hidesWhenStopped = true
               loadingIndicator.style = UIActivityIndicatorView.Style.gray
               loadingIndicator.startAnimating();
               loaderAlert.view.addSubview(loadingIndicator)
    }
    
    func getLoader() -> UIAlertController {
        return loaderAlert
    }
    
    //MARK:- API Work
   private func getTrendingRepositories() {
    if isApiRunning {
        return
    }
     self.observerBlock?(.dataLoading)
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
