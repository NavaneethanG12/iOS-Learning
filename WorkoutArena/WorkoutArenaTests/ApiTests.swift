//
//  ApiTests.swift
//  WorkoutArenaTests
//
//  Created by navaneeth-pt4855 on 15/06/22.
//

import Quick
import Nimble
import XCTest
import Dispatch

@testable import WorkoutArena

class ApiTests: QuickSpec{
    override func spec() {
        
        describe("network call") {
            var sut: DogViewModel!
            
            beforeEach {
                sut = DogViewModel()
            }
            
            context("to fetch models") {
                
                
                it("should contains 172 counts") {
                    sut.fetchModel()
                                            
//                        expect(sut.model.value.count).toEventually(equal(172), timeout: DispatchTimeInterval.seconds(120), pollInterval: DispatchTimeInterval.seconds(10), description: "models fetch fail")
                                            
                }
            }
            
            afterEach {
                sut = nil
            }
        }
        
        
    }
}

class WorkArenaTests: XCTestCase{
    
    var sut: DogViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = DogViewModel()
    }
    
    override func tearDownWithError() throws {
        
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_api_call_for_fetching_models(){
        
//        let promise = XCTestExpectation(description: "Api fetch failed")
        
//        let looper = Looper()
        
//        sut.fetchModel(){ value in
//
//            if let value = value as? [DogModel]{
//                XCTAssertEqual(value.count, 172, "Api Fetch for Dog model Count Mismatch")
//                promise.fulfill()
//            }
//        }
        
        sut.fetchModel()
        expect(self.sut.model.value.count).toEventually(equal(170), timeout: DispatchTimeInterval.seconds(20), pollInterval: DispatchTimeInterval.seconds(10), description: "fetch count mismatch")
        
//        var count = 0
//        looper.waitUntil(timeout: 50, repeatCount: 1, expectation: promise) {[weak self] in
//            count += 1
//            print("Timer count \(count)")
//            XCTAssertEqual(self?.sut.model.value.count, 172, "count mismatch")
//        }
//
//        expect(self.sut.model.value.count).toEventually(equal(172), timeout: DispatchTimeInterval.seconds(10), pollInterval: DispatchTimeInterval.seconds(1), description: "count mismatch")
//        wait(for: [promise], timeout: 20, enforceOrder: true)

    }
    
}


class Looper{
    
    var timer: Timer!
    var totalTime: CGFloat = 0
    var repeatTime: CGFloat = 0
    
    func waitUntil(timeout: CGFloat,repeatCount: Int = 1,expectation: XCTestExpectation,block: @escaping (()->Void)){
        totalTime = timeout
//        repeatTime = timeout / CGFloat(repeatCount)
        repeatTime = 1.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] timer in
            weak var _self = self
            guard let _self = _self else{ fatalError("Looper object is not available")}
            
            if (Int(totalTime) == 0){
                timer.invalidate()
                expectation.fulfill()
            }else{
                block()
                totalTime -= _self.repeatTime
            }
        })
    }
}



public func after(seconds seconds: TimeInterval, call closure: () -> Void) {
//    let delay = DispatchTime.now
//    let ontoQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, qos_class_t(0))
//    dispatch_after(delay, ontoQueue) {
//        print("\(seconds): finished waiting")
//        closure()
//        print("\(seconds): all done here")
//    }
    
}
   
    

