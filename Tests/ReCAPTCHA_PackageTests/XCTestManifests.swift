import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ReCAPTCHA_PackageTests.allTests),
    ]
}
#endif
