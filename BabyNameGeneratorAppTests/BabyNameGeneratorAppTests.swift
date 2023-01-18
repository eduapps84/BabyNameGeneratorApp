//
//  BabyNameGeneratorAppTests.swift
//  BabyNameGeneratorAppTests
//
//  Created by Eduardo Maia on 18/01/23.
//

import XCTest
@testable import BabyNameGeneratorApp

final class MockMainProtocol : MainViewModelProtocol {
    
    var babyResult: Baby?
    
    func setBaby(baby: Baby) {
        babyResult = baby
    }
    
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
        self.viewModel.fromServer = true
        self.viewModel.initBabyList()
        
        XCTAssert(viewModel.babies.count == 0, "Babies list should be empty")
    }
    
    func testGetRandomBaby() throws {
        self.viewModel.fromServer = false
        self.viewModel.initBabyList()
        self.viewModel.getRandomBaby(gender: 0)
        
        XCTAssertTrue(mockMainProtocol.babyResult != nil, "The result of random baby should not be null")
    }
}
