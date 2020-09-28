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
    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var retryButton: UIButton!
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
        repoTableView.accessibilityIdentifier = "RepoTableView"
        
        retryButton.layer.borderColor = #colorLiteral(red: 0.3607843137, green: 0.6862745098, blue: 0.3921568627, alpha: 1)
        retryButton.layer.borderWidth = 1
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
                    self?.noConnectionView.isHidden = true
                }
            case .dataFailed:
                print("Data Failed")
                DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                    self?.noConnectionView.isHidden = false
                }
            default:
                print("Default")
            }
        }
    }
    
    //MARK:- Action Methods
    @IBAction func retryAction(_ sender: UIButton) {
        viewModel.forceUpdate()
    }
    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repoCell = tableView.dequeueReusableCell(withIdentifier: viewModel.reusableIdentifier, for: indexPath) as! RepoTableCell
        repoCell.accessibilityIdentifier = String(format: "\(viewModel.reusableIdentifier)_%ld_%ld", indexPath.section, indexPath.row)
        repoCell.configureCell(viewModel: RepoCellViewModel.init(model: viewModel.items[indexPath.row]))
        return repoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoositoryDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "RepositoryDetailController") as! RepositoryDetailController
        repoositoryDetailVC.configureViewModel(model: viewModel.items[indexPath.row])
        navigationController?.pushViewController(repoositoryDetailVC, animated: true)
    }
}
