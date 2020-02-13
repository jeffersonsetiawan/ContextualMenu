//
//  CollectionVC.swift
//  PlayProject
//
//  Created by Jefferson Setiawan on 12/02/20.
//  Copyright © 2020 Jefferson Setiawan. All rights reserved.
//

import UIKit

internal final class CollectionVC: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.register(MyCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return col
    }()
    
    private let data: [String] = [
        "cell 1",
        "cell 2",
        "cell 3",
        "cell 4",
        "cell 5",
        "cell 6",
        "cell 7",
        "cell 4",
        "cell 5",
        "cell 6",
        "cell 7",
    ]
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyCollectionCell else { fatalError() }
        cell.bind(text: data[indexPath.row])
        return cell
    }
    
}

extension CollectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] suggestedActions -> UIMenu? in
            return self?.makeContextMenu()
        }

    }
    
    private func makeContextMenu() -> UIMenu {
        let favorite = UIAction(
            title: "Favorite",
            image: UIImage(systemName: "star.fill")) { _ in
                print("Favorite TAPPED")
            }

        let share = UIAction(
            title: "Share",
            image: UIImage(systemName: "square.and.arrow.up")) { _ in
                print("SHARE TAPPED")
            }
        
        let deleteCancel = UIAction(title: "Cancel", image: UIImage(systemName: "xmark")) { action in }
        let deleteConfirmation = UIAction(title: "Delete", image: UIImage(systemName: "checkmark"), attributes: .destructive) { action in }
        
        let delete = UIMenu(title: "Delete", image: UIImage(systemName: "trash"), options: .destructive, children: [deleteCancel, deleteConfirmation])

        return UIMenu(title: "",
                      image: nil,
                      identifier: nil,
                      children: [favorite, share, delete])
    }
}


internal final class MyCollectionCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemYellow
        self.addSubview(titleLabel)
        titleLabel.anchorCenter(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func bind(text: String) {
        titleLabel.text = text
    }
}
