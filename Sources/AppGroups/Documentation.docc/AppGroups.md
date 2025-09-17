# ``AppGroups``

A simple model for accessing app groups.

## Installation

Add the following dependency to your `Package.swift`:
```swift
.package(url: "https://github.com/sersoft-gmbh/app-groups", from: "1.0.0"),
```

Or add it via Xcode (as of Xcode 11).

## Usage

To use this package, simply create an ``AppGroup`` using the identifier of your app group (which you set up in Xcode's capabilities tab):

```swift
let appGroup = AppGroup(identifier: "group.your.app.group.identifier")
```

With that you can access the user defaults or file system:

```swift
let userDefaults = appGroup.userDefaults // `nil` if the app group is not valid.
let fileSystem = appGroup.fileSystem // `nil` if the app group is not valid.
```

The ``AppGroup/FileSystem`` object gives access to a few directories that are (usually) created when you access an app group.

For easier access and discoverability in your code, you can also add an extension:

```swift
extension AppGroup {
    static let myAppGroup = AppGroup(identifier: "group.your.app.group.identifier")
}
```
