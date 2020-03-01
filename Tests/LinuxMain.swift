import XCTest

import AES_ProviderTests

var tests = [XCTestCaseEntry]()
tests += AES_ProviderTests.allTests()
XCTMain(tests)
