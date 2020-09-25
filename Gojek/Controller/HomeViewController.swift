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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariables()
    }
    
    // MARK: - Custom Methods
    func initializeVariables() {
        let nib = UINib.init(nibName: "RepoTableCell", bundle: nil)
        repoTableView.register(nib, forCellReuseIdentifier: "RepoTableCell")
        
        viewModel.observerBlock = { (state) in
            switch state {
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.repoTableView.reloadData()
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
        let repoCell = tableView.dequeueReusableCell(withIdentifier: "RepoTableCell", for: indexPath) as! RepoTableCell
        repoCell.configureCell(viewModel: RepoCellViewModel.init(model: viewModel.items[indexPath.row]))
        return repoCell
    }
}
