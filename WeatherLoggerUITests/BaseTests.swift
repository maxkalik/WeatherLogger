//
//  Base.swift
//  WeatherLoggerUITests
//
//  Created by Maksim Kalik on 12/14/20.
//

import XCTest

class BaseTests: XCTestCase {

    let app = XCUIApplication()
    let saveButton = XCUIApplication().buttons["Save"]
    
    func testLaunchApp() throws {
        app.launch()
        XCTAssert(saveButton.exists)
    }
    
    func testSaveButtonTapAndShowDetails() throws {
        app.launch()
        saveButton.tap()
        let cell = app.tables.cells.firstMatch
        
        cell.tap()
        XCTAssert(app.navigationBars.buttons["Weather Logger"].exists)
        
        let generalLabel = app.scrollViews.staticTexts["General"]
        let detailsLabel = app.scrollViews.staticTexts["Details"]
        
        XCTAssert(generalLabel.exists)
        XCTAssert(detailsLabel.exists)
    }
}
