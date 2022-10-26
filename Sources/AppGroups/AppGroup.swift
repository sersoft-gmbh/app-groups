import Foundation

/// Represents an app group.
public struct AppGroup: Hashable, Codable, Sendable {
    /// The identifier of the app group. Usually starts with `group.your-chosen-identifier`.
    public let identifier: String

    /// The user defaults for this app group. `nil` if the app group is not valid.
    public var userDefaults: UserDefaults? {
        UserDefaults(suiteName: identifier)
    }

    /// The file system for this app group. `nil` if the app group is not valid.
    public var fileSystem: FileSystem? {
        FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: identifier)
            .map(FileSystem.init)
    }

    /// Creates a new app group with the given identifier.
    /// - Parameter identifier: The identifier of the new app group.
    public init(identifier: String) {
        self.identifier = identifier
    }

    public init(from decoder: Decoder) throws {
        try self.init(identifier: decoder.singleValueContainer().decode(String.self))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(identifier)
    }
}

extension AppGroup {
    /// Computes paths for the file system inside an app group.
    public struct FileSystem: Hashable {
        /// The root directory of the app group.
        public let root: URL

        private func _appendingDirectory(_ dirName: String, to base: URL) -> URL {
#if canImport(Darwin) && compiler(>=5.7.1)
            if #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) {
                return base.appending(component: dirName, directoryHint: .isDirectory)
            } else {
                return base.appendingPathComponent(dirName, isDirectory: true)
            }
#else
            return base.appendingPathComponent(dirName, isDirectory: true)
#endif
        }

        /// The "Library" directory inside the app group.
        public var library: URL {
            _appendingDirectory("Library", to: root)
        }

        /// The "Application Support" directory inside the "Library" folder.
        /// - SeeAlso: ``library``
        public var applicationSupport: URL {
            _appendingDirectory("Application Support", to: library)
        }

        /// The "Caches" directory inside the "Library" folder.
        /// - SeeAlso: ``library``
        public var caches: URL {
            _appendingDirectory("Caches", to: library)
        }

        /// The "Preferences" directory inside the "Library" folder.
        /// - SeeAlso: ``library``
        public var preferences: URL {
            _appendingDirectory("Preferences", to: library)
        }
    }
}

#if compiler(>=5.7)
extension AppGroup.FileSystem: Sendable {}
#endif
