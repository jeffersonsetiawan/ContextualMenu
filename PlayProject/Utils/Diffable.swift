//
//  Diffable.swift
//  PlayProject
//
//  Created by Jefferson Setiawan on 12/02/20.
//  Copyright © 2020 Jefferson Setiawan. All rights reserved.
//

import IGListKit

/**
 A diffable value type that can be used in conjunction with
 `DiffUtility` to perform a diff between two result sets.
 */
public protocol Diffable: Equatable {
    
    /**
     Returns a key that uniquely identifies the object.
     
     - returns: A key that can be used to uniquely identify the object.
     
     - note: Two objects may share the same identifier, but are not equal.
     
     - warning: This value should never be mutated.
     */
    var diffIdentifier: String { get }
}

public final class DiffableBox<T: Diffable>: ListDiffable {
    
    public let value: T
    public let identifier: NSObjectProtocol
    public let equal: (T, T) -> Bool
    
    public init(value: T, identifier: NSObjectProtocol, equal: @escaping(T, T) -> Bool) {
        self.value = value
        self.identifier = identifier
        self.equal = equal
    }
    
    // IGListDiffable
    
    public func diffIdentifier() -> NSObjectProtocol {
        return identifier
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let other = object as? DiffableBox<T> {
            return equal(value, other.value)
        }
        return false
    }
}

extension Sequence where Iterator.Element: Diffable {
    public func diffable() -> [ListDiffable] {
        let toListDiffable: [ListDiffable] = map { DiffableBox(value: $0, identifier: $0.diffIdentifier as NSObjectProtocol, equal: ==) }
        return toListDiffable
    }
}
