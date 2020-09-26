
//
//  RepositoryDetailController.swift
//  Gojek
//
//  Created by Neeraj Solanki on 26/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit
import WebKit
class RepositoryDetailController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starForkView: UIView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    //MARK:- Objects
    var viewModel:RepositoryDetailViewModel?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariables()
    }
    
    // MARK: - Custom Methods
    func initializeVariables()  {
        if let url = viewModel?.repoUrl {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        titleLabel.text = viewModel?.title
        starsLabel.text = viewModel?.stars
        forksLabel.text = viewModel?.forks
        descriptionLabel.text = viewModel?.descriptionValue
        title = viewModel?.controllerTitle
        
        starForkView.layer.borderColor = UIColor.gray.cgColor
        starForkView.layer.borderWidth =  0.5
        starForkView.layer.cornerRadius = 5
        
        userImageView.layer.borderColor = UIColor.gray.cgColor
        userImageView.layer.borderWidth =  0.3
        userImageView.layer.cornerRadius = userImageView.layer.frame.size.height / 2
        userImageView.clipsToBounds = true
    }
    
    func configureViewModel(model:RepositoryModel) {
        viewModel = RepositoryDetailViewModel.init(model: model)
        bindingWork()
    }
    
    func bindingWork() {
        viewModel?.observerBlock = {(observer) in
            switch observer {
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.userImageView.image = self.viewModel?.userImage
                }
            default:
                print("")
            }
        }
    }
}


