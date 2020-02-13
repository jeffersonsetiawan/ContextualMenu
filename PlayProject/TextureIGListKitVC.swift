////
////  TextureIGListKitVC.swift
////  PlayProject
////
////  Created by Jefferson Setiawan on 12/02/20.
////  Copyright © 2020 Jefferson Setiawan. All rights reserved.
////
//
//import AsyncDisplayKit
//import IGListKit
//
//internal final class TextureIGListKitVC: ASViewController<ASCollectionNode> {
//    private let collectionNode: ASCollectionNode = {
//        let layout = UICollectionViewFlowLayout()
//        let collectionNode = ASCollectionNode(collectionViewLayout: layout)
//        collectionNode.backgroundColor = .yellow
//        return collectionNode
//    }()
//    
//    private lazy var adapter: ListAdapter = {
//        let updater = ListAdapterUpdater()
//        let listAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
//        return listAdapter
//    }()
//    
//    var data: [IGDataWrapper] = [
//        IGDataWrapper(identifier: 1, data: .number(1)),
//        IGDataWrapper(identifier: 2, data: .number(2)),
//        IGDataWrapper(identifier: 3, data: .number(3)),
//        IGDataWrapper(identifier: 4, data: .number(4)),
//        IGDataWrapper(identifier: 5, data: .number(5)),
//        IGDataWrapper(identifier: 6, data: .number(6)),
//        IGDataWrapper(identifier: 7, data: .number(7)),
//        IGDataWrapper(identifier: 8, data: .text("8")),
//        IGDataWrapper(identifier: 9, data: .text("9")),
//        IGDataWrapper(identifier: 10, data: .text("10")),
//        IGDataWrapper(identifier: 11, data: .text("11")),
//        IGDataWrapper(identifier: 12, data: .text("12")),
//        IGDataWrapper(identifier: 13, data: .text("13")),
//        IGDataWrapper(identifier: 14, data: .text("14")),
//    ]
//    
//    override init() {
//        super.init(node: collectionNode)
//        title = "Texture With IGListKit ❌"
//        node.automaticallyManagesSubnodes = true
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        collectionNode.delegate = self
//        adapter.setASDKCollectionNode(collectionNode)
//        adapter.dataSource = self
//        
//        adapter.collectionView!.delegate = self
//        adapter.collectionViewDelegate = self
//    }
//    
//}
//
//extension TextureIGListKitVC: ASCollectionDelegate {
//    
//}
//
//extension TextureIGListKitVC: ASCollectionDataSource {
//    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//}
//
//
//
///// IG
//
//extension TextureIGListKitVC: ListAdapterDataSource {
//    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
//        return data.diffable()
//    }
//    
//    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
//        guard let wrapper = object as? DiffableBox<IGDataWrapper> else {
//            fatalError("Undefined wrapper class found \(String(describing: object)) expected DiffableBox<HomeDataWrapper>")
//        }
//        
//        switch wrapper.value.data {
//        case .number:
//            return TextureNumberSC()
//        case .text:
//            return TextureTextSC()
//        }
//    }
//    
//    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
//        return nil
//    }
//}
//
//
///// MARK: Context Menu
//extension TextureIGListKitVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] suggestedActions -> UIMenu? in
//            return self?.getContextMenu(for: indexPath)
//        }
//    }
//    
//    private func getContextMenu(for indexPath: IndexPath) -> UIMenu? {
//        guard let object = adapter.object(atSection: indexPath.section) as? DiffableBox<IGDataWrapper> else {
//            return nil
//        }
//        
//        switch object.value.data {
//        case .number: return getContextMenuForNumber()
//        case .text: return getContextMenuForText()
//        }
//        
//    }
//
//    private func getContextMenuForNumber() -> UIMenu? {
//        let share = UIAction(title: "Share Number", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] action in
//            let activityItems: [URL?] = [
//                URL(string: "https://tokopedia.com")
//            ]
//            let shareVc = UIActivityViewController(activityItems: [activityItems], applicationActivities: nil)
//            self?.present(shareVc, animated: true)
//        }
//        return UIMenu(title: "", children: [share])
//    }
//    
//    private func getContextMenuForText() -> UIMenu? {
//        let share = UIAction(title: "Share Text", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] action in
//            let activityItems: [URL?] = [
//                URL(string: "https://tokopedia.com")
//            ]
//            let shareVc = UIActivityViewController(activityItems: [activityItems], applicationActivities: nil)
//            self?.present(shareVc, animated: true)
//        }
//        return UIMenu(title: "", children: [share])
//    }
//}
//
//
//internal final class TextureNumberSC: ListSectionController, ASSectionController {
//    private var data: Int?
//    
//    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
//        return {
//            self.nodeForItem(at: index)
//        }
//    }
//    
//    func nodeForItem(at index: Int) -> ASCellNode {
//        guard let data = data else { return ASCellNode() }
//        let cell = MyNodeCell()
//        cell.bind(text: "Number \(data)")
//        cell.backgroundColor = .blue
//        return cell
//    }
//    
//    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
//        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
//    }
//    
//    internal override func didUpdate(to object: Any) {
//        guard let wrapper = object as? DiffableBox<IGDataWrapper>,
//            case let IGItemType.number(data) = wrapper.value.data else {
//                return
//        }
//        self.data = data
//    }
//}
//
//internal final class TextureTextSC: ListSectionController, ASSectionController {
//    private var data: String?
//    
//    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
//        return {
//            self.nodeForItem(at: index)
//        }
//    }
//    
//    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
//        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
//    }
//    
//    func nodeForItem(at index: Int) -> ASCellNode {
//        guard let data = data else { return ASCellNode() }
//        let cell = MyNodeCell()
//        cell.bind(text: "Number \(data)")
//        cell.backgroundColor = .red
//        return cell
//    }
//    
//    internal override func didUpdate(to object: Any) {
//        guard let wrapper = object as? DiffableBox<IGDataWrapper>,
//            case let IGItemType.text(data) = wrapper.value.data else {
//                return
//        }
//        self.data = data
//    }
//}
