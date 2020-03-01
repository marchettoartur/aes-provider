import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AES_ProviderTests.allTests),
    ]
}
#endif
