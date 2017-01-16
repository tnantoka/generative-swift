//
//  GenerativeSwiftTests.swift
//  GenerativeSwiftTests
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import XCTest
@testable import GenerativeSwift
import C4

class GenerativeSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testContains() {
        let line = Line(begin: Point(100, 100), end: Point(110, 110))
        let p1 = Point(105, 105)
        let p2 = Point(105, 104)
        let p3 = Point(99, 99)
        let p4 = Point(100, 105)
        print(line.frame)
        XCTAssertTrue(line.contains(p1))
        XCTAssertTrue(line.contains(p2))
        XCTAssertFalse(line.contains(p3))
        XCTAssertFalse(line.contains(p4))
    }
}
