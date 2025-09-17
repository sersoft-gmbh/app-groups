import Foundation
import Testing
@testable import AppGroups

@Suite
struct AppGroupTests {
    @Test
    func equatingAndHashing() {
        let appGroup1 = AppGroup(identifier: "group.test.one")
        let appGroup2 = AppGroup(identifier: "group.test.two")
        let appGroup3 = AppGroup(identifier: "group.test.one")

        #expect(appGroup1 == appGroup3)
        #expect(appGroup1 != appGroup2)
        #expect(appGroup2 != appGroup3)

        #expect(appGroup1.hashValue == appGroup3.hashValue)
        #expect(appGroup1.hashValue != appGroup2.hashValue)
        #expect(appGroup2.hashValue != appGroup3.hashValue)
    }

    @Test
    func codable() throws {
        struct Wrapper: Sendable, Codable {
            let group: AppGroup
        }
        
        let appGroup = AppGroup(identifier: "group.test.coding")
        let data = try JSONEncoder().encode(Wrapper(group: appGroup))
        #expect(String(decoding: data, as: UTF8.self) == #"{"group":"\#(appGroup.identifier)"}"#)
        let decodedGroup = try JSONDecoder().decode(Wrapper.self, from: data).group
        #expect(decodedGroup == appGroup)
    }

    @Test
    func computedAccessors() {
        let appGroup = AppGroup(identifier: "group.test.accessors")
        #expect(appGroup.userDefaults != nil)
#if !os(visionOS) // No idea why it works for a made up app group on non visionOS platforms...
        #expect(appGroup.fileSystem != nil)
#else
        #expect(appGroup.fileSystem == nil)
#endif
    }

    @Test
    func fileSystem() {
        let fs = AppGroup.FileSystem(root: URL(fileURLWithPath: "/Somewhere/"))
        #expect(fs.library.path == "/Somewhere/Library")
        #expect(fs.applicationSupport.path == "/Somewhere/Library/Application Support")
        #expect(fs.caches.path == "/Somewhere/Library/Caches")
        #expect(fs.preferences.path == "/Somewhere/Library/Preferences")
    }
}
