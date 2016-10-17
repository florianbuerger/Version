[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/florianbuerger/Version.svg?branch=master)](https://travis-ci.org/florianbuerger/Version)

# Version

This helps to deal with version in Swift in a type safe way. It only supports the offical [semantic versioning](http://semver.org) syntax.

It gives you a `struct` looking like this:

```swift
struct Version {
    let major: Int
    let minor: Int
    let patch: Int
    let suffix: String?
}
```

You can create a `Version` using the normal initializer providing values for `major`, `minor`, `patch` and `suffix` or provide a `String`, e.g. `1.2.3-beta4`.

## `CustomStringConvertible`

So it looks nice in the debugger

```
po version
1.2.3
```

## `Equatable`

Enables you to do stuff like `Version(string: "1.2.3") == Version(string: "1.2.3")`

## `Comparable`

This enables you to compare versions like `Version(string: "1.2.3") > Version(string: "2.3.4")`
