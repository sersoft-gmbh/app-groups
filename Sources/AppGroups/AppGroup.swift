import Foundation

/// Represents an app group.
public struct AppGroup: Hashable, Codable {
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

    /// See `Decodable.init(from:)`
    /// - Parameter decoder: The decoder.
    /// - Throws: `DecodingError`
    public init(from decoder: Decoder) throws {
        try self.init(identifier: decoder.singleValueContainer().decode(String.self))
    }

    /// See `Encodable.encode(to:)`
    /// - Parameter encoder: The encoder.
    /// - Throws: `EncodingError`
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

        /// The "Library" directory inside the app group.
        public var library: URL {
            root.appendingPathComponent("Library", isDirectory: true)
        }

        /// The "Application Support" directory inside the "Library" folder.
        /// - SeeAlso: `library`
        public var applicationSupport: URL {
            library.appendingPathComponent("Application Support", isDirectory: true)
        }

        /// The "Caches" directory inside the "Library" folder.
        /// - SeeAlso: `library`
        public var caches: URL {
            library.appendingPathComponent("Caches", isDirectory: true)
        }

        /// The "Preferences" directory inside the "Library" folder.
        /// - SeeAlso: `library`
        public var preferences: URL {
            library.appendingPathComponent("Preferences", isDirectory: true)
        }
    }
}

#if compiler(>=5.5) && canImport(_Concurrency)
extension AppGroup: Sendable {}
//extension AppGroup.FileSystem: Sendable {} // currently missing `URL`'s conformance to `Sendable`
#endif
