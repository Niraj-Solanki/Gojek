//
//  RepositoryDetailUITest.swift
//  GojekUITests
//
//  Created by Neeraj Solanki on 28/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//


import XCTest
class RepositoryDetailUITest: XCTestCase {
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
    
    func testNavigationTitle() {
        let githubNavigationBar = app.navigationBars["Github Trends"]
        XCTAssertTrue(githubNavigationBar.exists, "Github Trends list navigation bar not exist.")
        
        let myTable = app.tables.matching(identifier: "RepoTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "RepoTableCell_0_0")
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: cell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 30.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Failed time out waiting for rate")
        
        let NavigationTitleForDetailController = cell.staticTexts["RepoTableCell_Name"].label
        cell.tap()
        
        let detailRepositoryNavigationBar = app.navigationBars[NavigationTitleForDetailController]
        XCTAssertTrue(detailRepositoryNavigationBar.exists, "Repository Details navigation bar not exist.")
    }
    
    func testForklabel() {
       let githubNavigationBar = app.navigationBars["Github Trends"]
               XCTAssertTrue(githubNavigationBar.exists, "Github Trends list navigation bar not exist.")
               
               let myTable = app.tables.matching(identifier: "RepoTableView")
               let cell = myTable.cells.element(matching: .cell, identifier: "RepoTableCell_0_0")
               let predicate = NSPredicate(format: "isHittable == true")
               let expectationEval = expectation(for: predicate, evaluatedWith: cell, handler: nil)
               let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 30.0)
               XCTAssert(XCTWaiter.Result.completed == waiter, "Failed time out waiting for rate")
               
               let NavigationTitleForDetailController = cell.staticTexts["RepoTableCell_Name"].label
               cell.tap()
               
               let detailRepositoryNavigationBar = app.navigationBars[NavigationTitleForDetailController]
               XCTAssertTrue(detailRepositoryNavigationBar.exists, "Repository Details navigation bar not exist.")
      
            let forkLabel = app.staticTexts["Forks"].label
             XCTAssert(forkLabel.contains("Forks"), "Fork Lable not caontains proper value.")
                
    }
    
    func testStarslabel() {
          let githubNavigationBar = app.navigationBars["Github Trends"]
                  XCTAssertTrue(githubNavigationBar.exists, "Github Trends list navigation bar not exist.")
                  
                  let myTable = app.tables.matching(identifier: "RepoTableView")
                  let cell = myTable.cells.element(matching: .cell, identifier: "RepoTableCell_0_0")
                  let predicate = NSPredicate(format: "isHittable == true")
                  let expectationEval = expectation(for: predicate, evaluatedWith: cell, handler: nil)
                  let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 30.0)
                  XCTAssert(XCTWaiter.Result.completed == waiter, "Failed time out waiting for rate")
                  
                  let NavigationTitleForDetailController = cell.staticTexts["RepoTableCell_Name"].label
                  cell.tap()
                  
                  let detailRepositoryNavigationBar = app.navigationBars[NavigationTitleForDetailController]
                  XCTAssertTrue(detailRepositoryNavigationBar.exists, "Repository Details navigation bar not exist.")
         
               let starsLabel = app.staticTexts["Stars"].label
                XCTAssert(starsLabel.contains("Stars"), "Stars Lable not caontains proper value.")
       }
}
