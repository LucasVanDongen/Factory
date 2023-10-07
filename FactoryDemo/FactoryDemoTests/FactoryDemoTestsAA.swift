//
//  FactoryDemoTests.swift
//  FactoryDemoTests
//
//  Created by Michael Long on 4/5/23.
//
//  Testing issue https://github.com/hmlongco/Factory/issues/114
//

import XCTest

@testable import FactoryDemo

final class FactoryDemoTestsAA: XCTestCase {

    override func setUpWithError() throws {
        AAContainer.shared.manager.push()
    }

    override func tearDownWithError() throws {
        AAContainer.shared.manager.pop()
    }

    func testMockRegister() {
        let precache = AAViewModel()
        XCTAssertEqual(precache.name, "DefaultService")
        AAContainer.shared.service
            .register {
                AAMockService()
            }
            .reset(.scope)
        let sut = AAViewModel()
        XCTAssertEqual(sut.name, "MockService")
    }

    func testMockTest() {
        let precache = AAViewModel()
        XCTAssertEqual(precache.name, "DefaultService")
        AAContainer.shared.service
            .onTest {
                AAMockService()
            }
            .reset(.scope)
        let sut = AAViewModel()
        XCTAssertEqual(sut.name, "MockService")
    }

}
