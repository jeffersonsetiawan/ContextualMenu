////
////  TextureVC.swift
////  PlayProject
////
////  Created by Jefferson Setiawan on 12/02/20.
////  Copyright © 2020 Jefferson Setiawan. All rights reserved.
////
//
//import AsyncDisplayKit
//
//internal final class TextureVC: ASViewController<ASCollectionNode> {
//    private let collectionNode: ASCollectionNode = {
//        let layout = UICollectionViewFlowLayout()
//        let collectionNode = ASCollectionNode(collectionViewLayout: layout)
//        collectionNode.backgroundColor = .yellow
//        return collectionNode
//    }()
//    
//    private let data: [String] = [
//        "cell 1",
//        "cell 2",
//        "cell 3",
//        "cell 4",
//        "cell 5",
//        "cell 6",
//        "cell 7",
//        "cell 3",
//        "cell 4",
//        "cell 5",
//        "cell 6",
//        "cell 7",
//        "cell 3",
//        "cell 4",
//        "cell 5",
//        "cell 6",
//        "cell 7",
//    ]
//    
//    override init() {
//        super.init(node: collectionNode)
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
//        
//        collectionNode.delegate = self
//        collectionNode.dataSource = self
//    }
//    
//}
//
//extension TextureVC: ASCollectionDelegate {
//    
//    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
//        let cell = MyNodeCell()
//        cell.bind(text: data[indexPath.row])
//        cell.backgroundColor = .red
//        return cell
//    }
//}
//
//extension TextureVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] suggestedActions -> UIMenu? in
//            return self?.makeContextMenu()
//        }
//
//    }
//    
//    private func makeContextMenu() -> UIMenu {
//        let favorite = UIAction(
//            title: "Favorite",
//            image: UIImage(systemName: "star.fill")) { _ in
//                print("Favorite TAPPED")
//            }
//
//        let share = UIAction(
//            title: "Share",
//            image: UIImage(systemName: "square.and.arrow.up")) { _ in
//                print("SHARE TAPPED")
//            }
//        
//        let deleteCancel = UIAction(title: "Cancel", image: UIImage(systemName: "xmark")) { action in }
//        let deleteConfirmation = UIAction(title: "Delete", image: UIImage(systemName: "checkmark"), attributes: .destructive) { action in }
//        
//        let delete = UIMenu(title: "Delete", image: UIImage(systemName: "trash"), options: .destructive, children: [deleteCancel, deleteConfirmation])
//
//        return UIMenu(title: "",
//                      image: nil,
//                      identifier: nil,
//                      children: [favorite, share, delete])
//    }
//}
//
//extension TextureVC: ASCollectionDataSource {
//    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//}
//
//
//internal final class MyNodeCell: ASCellNode {
//    private let textNode = ASTextNode()
//    override init() {
//        super.init()
//        automaticallyManagesSubnodes = true
//    }
//    
//    internal func bind(text: String) {
//        textNode.attributedText = NSAttributedString(string: text)
//    }
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: textNode)
////        return ASWrapperLayoutSpec(layoutElement: textNode)
//    }
//}
