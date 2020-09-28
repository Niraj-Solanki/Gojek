//
//  HomeVCUnitTest.swift
//  GojekTests
//
//  Created by Neeraj Solanki on 28/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import XCTest
import CoreData
@testable import Gojek

class HomeVCUnitTest: XCTestCase {

    var homeViewController:HomeViewController!
        
    override func setUp() {
        homeViewController = HomeViewController()
    }

    override func tearDown() {
        
    }

    func testCellIdentifier() {
        XCTAssert(homeViewController.viewModel.reusableIdentifier == "RepoTableCell", "Cell ReusableIdentifier Mismatch.")
    }
        
    func testControllerTitle() {
        XCTAssert(homeViewController.navigationItem.title != "Github Trends","Invalid Navigation Title")
    }
}
