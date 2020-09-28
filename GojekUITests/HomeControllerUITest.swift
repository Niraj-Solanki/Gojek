//
//  HomeControllerUITest.swift
//  GojekUITests
//
//  Created by Neeraj Solanki on 28/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit
import XCTest
class HomeControllerUITest: XCTestCase {
    var app:XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNavigationHomeView() {
        let githubNavigationBar = app.navigationBars["Github Trends"]
        XCTAssertTrue(githubNavigationBar.exists, "Github Trends list navigation bar not exist.")
    }
    
    func testRepositoryDetailsNavigationFromHomeViewController() {
        let myTable = app.tables.matching(identifier: "RepoTableView")
            let cell = myTable.cells.element(matching: .cell, identifier: "RepoTableCell_0_0")
            let predicate = NSPredicate(format: "isHittable == true")
            let expectationEval = expectation(for: predicate, evaluatedWith: cell, handler: nil)
            let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 30.0)
            XCTAssert(XCTWaiter.Result.completed == waiter, "Failed time out waiting for rate")
            
            let NavigationTitleForDetailController = cell.staticTexts["RepoTableCell_Name"].label
            cell.tap()
            
            let detailRepositoryNavigationBar = app.navigationBars[NavigationTitleForDetailController]
            let backButton = detailRepositoryNavigationBar.buttons["Github Trends"]
            let backButtonDefault = detailRepositoryNavigationBar.buttons["Back"]
            XCTAssertTrue(backButton.exists && (detailRepositoryNavigationBar.exists || backButtonDefault.exists), "Github Trends list navigation bar not exist.")
    }
}
