//
//  RepositoryDetailTest.swift
//  GojekTests
//
//  Created by Neeraj Solanki on 28/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import XCTest
import CoreData
@testable import Gojek

class RepositoryDetailTest: XCTestCase {

    var repositoryDetailController:RepositoryDetailController!
        
    override func setUp() {
        repositoryDetailController = RepositoryDetailController()
    }

    override func tearDown() {
        
    }

    func testControllerTitle() {
        //Controller Title Must Same as Repository Name
        XCTAssert(repositoryDetailController.title == repositoryDetailController.viewModel?.title, "Controller Title Mismatch")
    }
    
    func testViewModel() {
        //Controller Title Must Same as Repository Name
        repositoryDetailController.configureViewModel(model: RepositoryModel.init())
        XCTAssert(repositoryDetailController.viewModel != nil, "ViewModel Found Nil")
    }
    
    func testViewModelWithParitialData() {
           //Controller Title Must Same as Repository Name
        var model = RepositoryModel()
            model.author = nil
            model.name = nil
           repositoryDetailController.configureViewModel(model: model)
           XCTAssert(repositoryDetailController.viewModel != nil, "ViewModel Found Nil")
       }
        
}
