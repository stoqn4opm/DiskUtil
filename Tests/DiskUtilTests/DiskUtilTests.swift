import XCTest
@testable import DiskUtil

@available(OSX 10.13, *)
final class DiskUtilTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let expectation = XCTestExpectation(description: "mount,erase,eject")
        
        DiskUtil.createDiskImage(withSize: 100) { (responce) in
            guard responce.error.isEmpty else { XCTFail(); return }
            let devicePath = responce.output
            
            DiskUtil.eraseDisk(withDevicePath: devicePath, name: "Test Disk", fileSystem: .apfs) { (responce) in
                guard responce.error.isEmpty else { XCTFail(); return }
                
                DiskUtil.ejectDisk(withDevicePath: devicePath) { (responce) in
                    guard responce.error.isEmpty else { XCTFail(); return }
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 5)
        
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
