//
//  RepoTableCell.swift
//  Gojek
//
//  Created by Neeraj Solanki on 25/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit

class RepoTableCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.accessibilityIdentifier = "RepoTableCell_Name"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Custom Methods
    func configureCell(viewModel:RepoCellViewModel) {
        nameLabel.text = viewModel.name
        starsLabel.text = viewModel.stars
        descriptionLabel.text = viewModel.description
    }
}
