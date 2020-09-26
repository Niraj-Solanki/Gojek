//
//  RepositoryDetailViewModel.swift
//  Gojek
//
//  Created by Neeraj Solanki on 26/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit

class RepositoryDetailViewModel {

    var observerBlock:((_ observerType:ObserverTypeEnum)->Void)?
    private var reposirotyModel:RepositoryModel?
    init(model:RepositoryModel) {
        reposirotyModel = model
        fetchUserImage()
    }
    
    var userImage:UIImage?{
        didSet{
            observerBlock?(.dataLoaded)
        }
    }
    
    var title:String{
        return reposirotyModel?.author ?? ""
    }
    
    var descriptionValue:String{
        return reposirotyModel?.description ?? ""
    }
    
    var controllerTitle:String{
        return reposirotyModel?.name ?? ""
    }
    
    var stars:String{
        return "\(reposirotyModel?.stars ?? 0) Stars"
    }
    
    var forks:String{
        return "\(reposirotyModel?.forks ?? 0) Forks"
    }
    
    var repoUrl:URL?{
        return URL.init(string: reposirotyModel?.url ?? "")
    }
 
    
    private func fetchUserImage() {
        if let imageUrl = URL.init(string: reposirotyModel?.avatar ?? "")
        {
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                guard let data = data, error == nil else { return print("Not Available") }
                
                DispatchQueue.main.async {
                    let fetchedImage = UIImage(data: data)
                    guard let image = fetchedImage else { return }
                    self.userImage  = image
                }
            }).resume()
        }
    }
}
