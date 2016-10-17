import XCTest
@testable import Version

class VersionTests: XCTestCase {
    
    func testInit() {
        
        XCTAssertNil(Version(string: "afdas"))
        XCTAssertNil(Version(string: "1.2.alsuhda"))
        
        XCTAssertEqual(Version(string: "1"), Version(major: 1, minor: 0, patch: 0))
        
        XCTAssertEqual(Version(string: "1.2"), Version(major: 1, minor: 2, patch: 0))
        
        XCTAssertEqual(Version(string: "1.2.3"), Version(major: 1, minor: 2, patch: 3))
    }
    
    func testDiscardInvalidSuffix() {
        XCTAssertEqual(Version(string: "1.2.3_alpha"), Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(Version(string: "1.2.3_1432"), Version(major: 1, minor: 2, patch: 3))
    }
    
    func testSuffix() {
        XCTAssertEqual(Version(string: "1.2.3-alpha"), Version(major: 1, minor: 2, patch: 3, suffix: "alpha"))
        XCTAssertEqual(Version(string: "1.2.433-rc1.1.0"), Version(major: 1, minor: 2, patch: 433, suffix: "rc1.1.0"))
    }
    
    func testEquality() {
        let one = Version(major: 0, minor: 0, patch: 0)
        let two = Version(major: 0, minor: 0, patch: 0)
        XCTAssertEqual(one, two)
        
        let three = Version(major: 0, minor: 1, patch: 2)
        XCTAssertNotEqual(one, three)
    }
    
    func testLessThan() {
        let one = Version(major: 0, minor: 1, patch: 0)
        let two = Version(major: 0, minor: 0, patch: 1)
        XCTAssertLessThan(two, one)
        
        let three = Version(major: 0, minor: 0, patch: 2)
        XCTAssertLessThan(two, three)
        
        let four = Version(major: 1, minor: 0, patch: 0)
        XCTAssertLessThan(three, four)
    }
    
    func testLessThanOrEqual() {
        let one = Version(major: 2, minor: 4, patch: 15)
        let two = Version(major: 2, minor: 4, patch: 15)
        XCTAssertLessThanOrEqual(one, two)
        
        let three = Version(major: 2, minor: 4, patch: 14)
        XCTAssertLessThanOrEqual(three, two)
    }
    
    func testGreaterThan() {
        let one = Version(major: 0, minor: 2, patch: 4)
        let two = Version(major: 1, minor: 0, patch: 0)
        XCTAssertGreaterThan(two, one)
        
        let three = Version(major: 0, minor: 3, patch: 0)
        XCTAssertGreaterThan(three, one)
        
        let four = Version(major: 1, minor: 0, patch: 1)
        XCTAssertGreaterThan(four, two)
    }
    
    func testGreaterThanOrEqual() {
        let one = Version(major: 0, minor: 2, patch: 1)
        let two = Version(major: 0, minor: 2, patch: 1)
        
        XCTAssertGreaterThanOrEqual(one, two)
        
        let three = Version(major: 0, minor: 2, patch: 2)
        XCTAssertGreaterThanOrEqual(three, two)
        
        let four = Version(major: 1, minor: 0, patch: 0)
        XCTAssertGreaterThanOrEqual(four, three)
    }
}
