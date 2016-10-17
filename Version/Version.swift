//
//  Copyright © 2016 Florian Bürger. All rights reserved.
//

import Foundation

public struct Version {
    let major: Int
    let minor: Int
    let patch: Int
    let suffix: String?
    
    init(major: Int, minor: Int, patch: Int, suffix: String = "") {
        self.major = major
        self.minor = minor
        self.patch = patch
        if suffix.isEmpty == false {
            self.suffix = "-".appending(suffix)
        } else {
            self.suffix = ""
        }
    }
}

extension Version {
    
    init?(string: String) {
        
        var input = string
        if let suffixRange = input.range(of: "-") {
            input = string.substring(to: suffixRange.lowerBound)
            suffix = string.substring(from: suffixRange.lowerBound)
        } else {
            suffix = ""
        }
        
        let components = input.components(separatedBy: ".")
        
        guard let major = Int(components[0]) else { return nil }
        self.major = major
        
        switch components.count {
        case 1:
            minor = 0
            patch = 0
        case 2:
            guard let minor = Int(components[1]) else { return nil }
            self.minor = minor
            patch = 0
        case 3:
            guard let minor = Int(components[1]) else { return nil }
            self.minor = minor

            var component = components[2]
            if let range = component.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) {
                component = component.substring(to: range.lowerBound)
            }
            
            guard let patch = Int(component) else { return nil }
            self.patch = patch
        default:
            return nil
        }
    }
    
}

extension Version: CustomStringConvertible {
    public var description: String {
        var string = "\(major).\(minor).\(patch)"
        if let suffix = self.suffix {
            string = string.appending(suffix)
        }
        return string
    }
}

extension Version: Equatable {}
public func ==(lhs: Version, rhs: Version) -> Bool {
    return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch == rhs.patch
}

extension Version: Comparable {}

public func <(lhs: Version, rhs: Version) -> Bool {
    if lhs.major < rhs.major { return true }
    if lhs.major == rhs.major && lhs.minor < rhs.minor { return true }
    if lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch < rhs.patch { return true }
    return false
}

public func <=(lhs: Version, rhs: Version) -> Bool {
    if lhs == rhs { return true }
    return lhs < rhs
}

public func >(lhs: Version, rhs: Version) -> Bool {
    if lhs.major > rhs.major { return true }
    if lhs.major == rhs.major && lhs.minor > rhs.minor { return true }
    if lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch > rhs.patch { return true }
    return false
}

public func >=(lhs: Version, rhs: Version) -> Bool {
    if lhs == rhs { return true }
    return lhs > rhs
}
