import XCTest
@testable import AppGroups

final class AppGroupTests: XCTestCase {
    func testEquatingAndHashing() {
        let appGroup1 = AppGroup(identifier: "group.test.one")
        let appGroup2 = AppGroup(identifier: "group.test.two")
        let appGroup3 = AppGroup(identifier: "group.test.one")

        XCTAssertEqual(appGroup1, appGroup3)
        XCTAssertNotEqual(appGroup1, appGroup2)
        XCTAssertNotEqual(appGroup2, appGroup3)

        XCTAssertEqual(appGroup1.hashValue, appGroup3.hashValue)
        XCTAssertNotEqual(appGroup1.hashValue, appGroup2.hashValue)
        XCTAssertNotEqual(appGroup2.hashValue, appGroup3.hashValue)
    }

    func testCodable() throws {
        struct Wrapper: Sendable, Codable {
            let group: AppGroup
        }
        
        let appGroup = AppGroup(identifier: "group.test.coding")
        let data = try JSONEncoder().encode(Wrapper(group: appGroup))
        XCTAssertEqual(String(decoding: data, as: UTF8.self),
                       #"{"group":"\#(appGroup.identifier)"}"#)
        let decodedGroup = try JSONDecoder().decode(Wrapper.self, from: data).group
        XCTAssertEqual(decodedGroup, appGroup)
    }

    func testAccessors() {
        let appGroup = AppGroup(identifier: "group.test.accessors")
#if !os(visionOS) // No idea why it works on these platforms...
        XCTAssertNotNil(appGroup.userDefaults)
        XCTAssertNotNil(appGroup.fileSystem)
#else
        XCTAssertNil(appGroup.userDefaults)
        XCTAssertNil(appGroup.fileSystem)
#endif
    }

    func testFileSystem() {
        let fs = AppGroup.FileSystem(root: URL(fileURLWithPath: "/Somewhere/"))
        XCTAssertEqual(fs.library.path, "/Somewhere/Library")
        XCTAssertEqual(fs.applicationSupport.path, "/Somewhere/Library/Application Support")
        XCTAssertEqual(fs.caches.path, "/Somewhere/Library/Caches")
        XCTAssertEqual(fs.preferences.path, "/Somewhere/Library/Preferences")
    }
}
