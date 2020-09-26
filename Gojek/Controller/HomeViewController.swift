//
//  HomeViewController.swift
//  Gojek
//
//  Created by Neeraj Solanki on 25/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var repoTableView: UITableView!
    
    // MARK: - Objetcs
    let viewModel = HomeViewModel()
    var refreshControl = UIRefreshControl()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariables()
    }
    
    // MARK: - Custom Methods
    func initializeVariables() {
        repoTableView.register(viewModel.nib, forCellReuseIdentifier: viewModel.reusableIdentifier)
        
        refreshControl.attributedTitle = viewModel.refreshTitle
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        repoTableView.refreshControl = refreshControl
        
        bindingSetup()
    }
     
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewModel.forceUpdate()
    }
    
    func bindingSetup() {
        viewModel.observerBlock = {  [weak self] (state) in
            switch state {
            case .dataLoaded:
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                    self?.repoTableView.reloadData()
                }
            case .dataLoading:
                print("Data Loading")
            default:
                print("Default")
            }
        }
    }
    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repoCell = tableView.dequeueReusableCell(withIdentifier: viewModel.reusableIdentifier, for: indexPath) as! RepoTableCell
        repoCell.configureCell(viewModel: RepoCellViewModel.init(model: viewModel.items[indexPath.row]))
        return repoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoositoryDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "RepositoryDetailController") as! RepositoryDetailController
        repoositoryDetailVC.configureViewModel(model: viewModel.items[indexPath.row])
        navigationController?.pushViewController(repoositoryDetailVC, animated: true)
    }
}
