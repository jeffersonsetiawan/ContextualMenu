//
//  StaticVC.swift
//  PlayProject
//
//  Created by Jefferson Setiawan on 12/02/20.
//  Copyright © 2020 Jefferson Setiawan. All rights reserved.
//

import UIKit

internal final class StaticVC: UIViewController {
    private let staticView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.anchorSize(to: CGSize(width: 300, height: 300))
        return view
    }()

    override func loadView() {
        super.loadView()
        title = "Static VC"
        view.backgroundColor = .white
        view.addSubview(staticView)

        staticView.anchorCenter(to: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let interaction = UIContextMenuInteraction(delegate: self)
        staticView.addInteraction(interaction)
    }
}

extension StaticVC: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        animator.addCompletion {
            if let vc = animator.previewViewController {
                self.show(vc, sender: self)
            }
        }
    }
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
//            previewProvider: nil
            previewProvider: TableVC.init
        ) { _ -> UIMenu? in
            self.makeContextMenu()
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
