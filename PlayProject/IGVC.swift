//
//  IGVC.swift
//  PlayProject
//
//  Created by Jefferson Setiawan on 12/02/20.
//  Copyright © 2020 Jefferson Setiawan. All rights reserved.
//

import IGListKit
import UIKit

internal final class IGVC: UIViewController {
    var data: [IGDataWrapper] = [
        IGDataWrapper(identifier: 1, data: .number(1)),
        IGDataWrapper(identifier: 2, data: .number(2)),
        IGDataWrapper(identifier: 3, data: .number(3)),
        IGDataWrapper(identifier: 4, data: .number(4)),
        IGDataWrapper(identifier: 5, data: .number(5)),
        IGDataWrapper(identifier: 6, data: .number(6)),
        IGDataWrapper(identifier: 7, data: .number(7)),
        IGDataWrapper(identifier: 8, data: .text("8")),
        IGDataWrapper(identifier: 9, data: .text("9")),
        IGDataWrapper(identifier: 10, data: .text("10")),
        IGDataWrapper(identifier: 11, data: .text("11")),
        IGDataWrapper(identifier: 12, data: .text("12")),
        IGDataWrapper(identifier: 13, data: .text("13")),
        IGDataWrapper(identifier: 14, data: .text("14")),
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var adapter: ListAdapter = {
        let updater = ListAdapterUpdater()
        let listAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
        return listAdapter
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.collectionViewDelegate = self
        adapter.dataSource = self
    }
}

extension IGVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
                return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] suggestedActions -> UIMenu? in
            return self?.getContextMenu(for: indexPath)
        }
    }
    
    private func getContextMenu(for indexPath: IndexPath) -> UIMenu? {
        guard let cell = adapter.collectionView?.cellForItem(at: indexPath),
            let object = adapter.object(atSection: indexPath.section) as? DiffableBox<IGDataWrapper> else {
            return nil
        }
        
        switch object.value.data {
        case .number: return getContextMenuForNumber()
        case .text: return getContextMenuForText()
        }
        
    }

    private func getContextMenuForNumber() -> UIMenu? {
        let share = UIAction(title: "Share Number", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] action in
            let activityItems: [URL?] = [
                URL(string: "https://tokopedia.com")
            ]
            let shareVc = UIActivityViewController(activityItems: [activityItems], applicationActivities: nil)
//            shareVc.popoverPresentationController?.sourceView = cell
            self?.present(shareVc, animated: true)
        }
        return UIMenu(title: "", children: [share])
    }
    
    private func getContextMenuForText() -> UIMenu? {
        let share = UIAction(title: "Share Text", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] action in
            let activityItems: [URL?] = [
                URL(string: "https://tokopedia.com")
            ]
            let shareVc = UIActivityViewController(activityItems: [activityItems], applicationActivities: nil)
//            shareVc.popoverPresentationController?.sourceView = cell
            self?.present(shareVc, animated: true)
        }
        return UIMenu(title: "", children: [share])
    }
}

extension IGVC: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data.diffable()
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let wrapper = object as? DiffableBox<IGDataWrapper> else {
            fatalError("Undefined wrapper class found \(String(describing: object)) expected DiffableBox<HomeDataWrapper>")
        }
        
        switch wrapper.value.data {
        case .number:
            return NumberSC()
        case .text:
            return TextSC()
        }
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
