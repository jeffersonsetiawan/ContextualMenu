//
//  IGDataWrapper.swift
//  PlayProject
//
//  Created by Jefferson Setiawan on 12/02/20.
//  Copyright © 2020 Jefferson Setiawan. All rights reserved.
//

import IGListKit

/// MARK: SC

internal final class NumberSC: ListSectionController {
    
    private var data: Int?
    
    internal override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 188)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let collectionContext = collectionContext,
            let cell = collectionContext.dequeueReusableCell(of: MyCollectionCell.self, withReuseIdentifier: "number-cell", for: self, at: index) as? MyCollectionCell,
            let data = data else {
                fatalError("Cannot retreive cell")
        }
        cell.bind(text: "NUMBER CELL \(data)")
        cell.backgroundColor = .systemTeal
        return cell
    }
    
    internal override func didUpdate(to object: Any) {
        guard let wrapper = object as? DiffableBox<IGDataWrapper>,
            case let IGItemType.number(data) = wrapper.value.data else {
                return
        }
        self.data = data
    }
}

internal final class TextSC: ListSectionController {
    private var data: String?
    internal override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let collectionContext = collectionContext,
            let cell = collectionContext.dequeueReusableCell(of: MyCollectionCell.self, withReuseIdentifier: "text-cell", for: self, at: index) as? MyCollectionCell,
            let data = data else {
                fatalError("Cannot retreive cell")
        }
        cell.bind(text: "TEXT CELL \(data)")
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    internal override func didUpdate(to object: Any) {
        guard let wrapper = object as? DiffableBox<IGDataWrapper>,
            case let IGItemType.text(data) = wrapper.value.data else {
                return
        }
        self.data = data
    }
}

/// MARK: Data

internal struct IGDataWrapper {
    internal let identifier: Int
    internal let data: IGItemType
}

internal enum IGItemType: Equatable {
    case number(Int)
    case text(String)
}

extension IGDataWrapper: Diffable {
    internal var diffIdentifier: String {
        return String(identifier)
    }
}
