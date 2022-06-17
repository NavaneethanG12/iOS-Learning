//
//  WorkoutArenaTests.swift
//  WorkoutArenaTests
//
//  Created by navaneeth-pt4855 on 10/06/22.
//

import XCTest
import Quick
import Nimble

@testable import WorkoutArena

class WorkoutArenaTests: XCTestCase {
    
    var mut: DataManager!
    var vmut: DogViewModel!
    let networkMonitor = NetworkMonitor.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        mut = DataManager()
        vmut = DogViewModel()
        
    }

    override func tearDownWithError() throws {
        mut = nil
        vmut = nil
        try super.tearDownWithError()
        
    }

    func testNetworkCall() throws {
        
        try XCTSkipUnless(networkMonitor.isReachable, "Connect to network")
        

        let promise = expectation(description: "Data fetched successfully")
        mut.fetchData(urlString: "https://api.thedogapi.com/v1/breeds", type: [DogModel].self) {
            value in
            if let value = value {
                promise.fulfill()
            }else{
                XCTFail("Data fetch error")
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testDogViewModelBinding() throws{
        
        let promise = expectation(description: "Data Available")
        vmut.fetchModel(){ _ in
            
        }
        vmut.model.bind { value in
            if value.count == 172{
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 10)
    }

    func testAuthenticator(){
        
        let auth = Authenticator()
        auth.authenticate(with: "1234") { value in
            XCTAssertTrue(value)
        }
        
    }
    
    func test_using_quick_and_nimble(){
        expect(1 + 1).to(equal(2))
        expect(1.2).to(beCloseTo(1.1, within: 0.1))
        expect(3) > 2
        expect("seahorse").to(contain("sea"))
        expect(["Atlantic", "Pacific"]).toNot(contain("Mississippi"))
    }
}
