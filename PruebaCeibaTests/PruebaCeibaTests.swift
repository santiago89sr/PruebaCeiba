//
//  PruebaCeibaTests.swift
//  PruebaCeibaTests
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import XCTest
@testable import PruebaCeiba

class PruebaCeibaTests: XCTestCase {
    
    var usersMV:UsersViewModel?

    override func setUp() async throws {
        self.usersMV = UsersViewModel()
    }
    
    override func tearDown() async throws {
        self.usersMV = nil
    }

    func testGetUsersFromDB() throws {
        self.usersMV!.validateGetUsers()
        let users = usersMV?.users
        XCTAssertNotNil(users)
    }

    func testPerformanceExample() throws {
        
        self.measure {
            
        }
    }

}
