//
//  BabyNameGeneratorAppUITests.swift
//  BabyNameGeneratorAppUITests
//
//  Created by Eduardo Maia on 18/01/23.
//

import XCTest

final class BabyNameGeneratorAppUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
    
    func testUIElements() throws {
        app.launch()
        
        XCTAssertTrue(app.staticTexts["Choose the gender:"].exists)
    }
    
    func testMaleButton() throws {
        app.launch()
        
        let maleButton = app.buttons["male"]
        
        XCTAssertTrue(maleButton.exists)
        
        maleButton.tap()
        
        XCTAssertTrue(!app.staticTexts["baby_info"].label.isEmpty)
        XCTAssertTrue(app.staticTexts["Name:"].exists)
    }
    
    func testFemaleButton() throws {
        app.launch()
        
        let femaleButton = app.buttons["female"]
        
        XCTAssertTrue(femaleButton.exists)
        
        femaleButton.tap()
        
        XCTAssertTrue(!app.staticTexts["baby_info"].label.isEmpty)
        XCTAssertTrue(app.staticTexts["Name:"].exists)
    }
}
