//
//  DataManager.swift
//  Gojek
//
//  Created by Neeraj Solanki on 27/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit
import CoreData

class DataManager {
    
   static let shared = DataManager()
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Gojek")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func insertRepositories(repositories: [RepositoryModel]) throws {
        try deleteOldRepositories() // Force Updgrade Data
        
        for repoModel in repositories {
            let repository = Repository(context: context)
            repository.author = repoModel.author
            repository.avatar = repoModel.avatar
            repository.forks = Int64(repoModel.forks ?? 0)
            repository.stars = Int64(repoModel.stars ?? 0)
            repository.name = repoModel.name
            repository.repoDescription = repoModel.description
            repository.url = repoModel.url
            repository.timestamp = Date().timeIntervalSince1970
            context.insert(repository)
        }
        saveData()
    }
    
    func fetchRepositories() throws -> [RepositoryModel] {
        var repositoriesData = try self.context.fetch(Repository.fetchRequest() as NSFetchRequest<Repository>)
        print("Fetched")
        
        repositoriesData = repositoriesData.filter({ (repo) -> Bool in
            repo.timestamp > Date().timeIntervalSince1970 - 7200
        })
        
        var repositories:[RepositoryModel] = []
        
        for repo in repositoriesData {
            var repository:RepositoryModel = RepositoryModel()
            repository.author = repo.author
            repository.avatar = repo.avatar
            repository.name = repo.name
            repository.url = repo.url
            repository.description = repo.repoDescription
            repository.stars = Int(repo.stars)
            repository.forks = Int(repo.forks)
            repositories.append(repository)
        }
        return repositories
    }
    
    func deleteOldRepositories() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
           try context.execute(deleteRequest)
           saveData()
    }
    
    func saveData() {
        if context.hasChanges {
            do {
                try context.save()
                print("CoreData Updated")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
