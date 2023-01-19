//
//  BabyNameGeneratorAppTests.swift
//  BabyNameGeneratorAppTests
//
//  Created by Eduardo Maia on 18/01/23.
//

import XCTest
@testable import BabyNameGeneratorApp

final class MockMainProtocol : MainViewModelProtocol {
    
    var error: String?
    
    func babyListFilled() {}
    
    func babyListFilledError(error: String) {
        self.error = error
    }
    
    func setBaby() {}
    func errorSearch() {}
}

final class BabyNameGeneratorAppTests: XCTestCase {

    var viewModel: MainViewModel!
    var mockMainProtocol: MockMainProtocol!
    
    override func setUpWithError() throws {
        self.mockMainProtocol = MockMainProtocol()
        self.viewModel = MainViewModel(withDelegate: mockMainProtocol)
    }

    override func tearDownWithError() throws {
        self.mockMainProtocol = nil
        self.viewModel = nil
    }
    
    func testInitBabyListLocal() throws {
        self.viewModel.fromServer = false
        self.viewModel.initBabyList()
        
        XCTAssert(viewModel.babies.count > 0, "Babies list should not be empty")
    }

    func testInitBabyListServer() throws {
        let babyService = BabyNamesService()
        let expectation = XCTestExpectation(description: "response")
        
        babyService.fetchBabyList(completion: { list, error in
            XCTAssert(error.count > 0, "Babies list should be empty")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetRandomBaby() throws {
        self.viewModel.fromServer = false
        self.viewModel.initBabyList()
        self.viewModel.getRandomBaby(gender: 0)
        
        XCTAssertTrue(viewModel.babyCard != nil, "The result of random baby should not be null")
    }
}
