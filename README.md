# App Groups

[![GitHub release](https://img.shields.io/github/release/sersoft-gmbh/app-groups.svg?style=flat)](https://github.com/sersoft-gmbh/app-groups/releases/latest)
![Tests](https://github.com/sersoft-gmbh/app-groups/workflows/Tests/badge.svg)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/74c834e51f6c42bdba5fdd5718f7bb42)](https://www.codacy.com/gh/sersoft-gmbh/app-groups/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=sersoft-gmbh/app-groups&amp;utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/sersoft-gmbh/app-groups/branch/main/graph/badge.svg?token=3FKU261VRC)](https://codecov.io/gh/sersoft-gmbh/app-groups)
[![Docs](https://img.shields.io/badge/-documentation-informational)](https://sersoft-gmbh.github.io/app-groups)

A simple model for accessing app groups.

## Installation

Add the following dependency to your `Package.swift`:
```swift
.package(url: "https://github.com/sersoft-gmbh/app-groups.git", from: "1.0.0"),
```

Or add it via Xcode (as of Xcode 11).

## Usage

To use this package, simply create an `AppGroup` using the identifier of your app group (which you set up in Xcode's capabilities tab):

```swift
let appGroup = AppGroup(identifier: "group.your.app.group.identifier")
```

With that you can access the user defaults or file system:

```swift
let userDefaults = appGroup.userDefaults // `nil` if the app group is not valid.
let fileSystem = appGroup.fileSystem // `nil` if the app group is not valid.
```

The `AppGroup.FileSystem` object gives access to a few directories that are (usually) created when you access an app group.

## Possible Features

While not yet integrated, the following features might provide added value and could make it into this package in the future:

-   Add an `AppGroup.Existing` model that has non-optional properties to make passing around easier.

## Documentation

The API is documented using header doc. If you prefer to view the documentation as a webpage, there is an [online version](https://sersoft-gmbh.github.io/app-groups) available for you.

## Contributing

If you find a bug / like to see a new feature in this package there are a few ways of helping out:

-   If you can fix the bug / implement the feature yourself please do and open a PR.
-   If you know how to code (which you probably do), please add a (failing) test and open a PR. We'll try to get your test green ASAP.
-   If you can do neither, then open an issue. While this might be the easiest way, it will likely take the longest for the bug to be fixed / feature to be implemented.

## License

See [LICENSE](./LICENSE) file.
