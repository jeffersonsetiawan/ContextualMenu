//
//  TableVC.swift
//  PlayProject
//
//  Created by Jefferson Setiawan on 12/02/20.
//  Copyright © 2020 Jefferson Setiawan. All rights reserved.
//

import UIKit

internal final class TableVC: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyTableCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let data: [String] = [
        "cell 1",
        "cell 2",
        "cell 3",
        "cell 4",
        "cell 5",
        "cell 6",
        "cell 7",
    ]
    
    override func loadView() {
        super.loadView()
        title = "TableVC"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TableVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

extension TableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MyTableCell else {
            fatalError()
        }
        cell.bind(text: data[indexPath.row])
//        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    private func getTargetedPreview(for configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let identifier = configuration.identifier as? Int else { return nil }
        guard let cell = tableView.cellForRow(at: .init(row: identifier, section: 0)) as? MyTableCell else { return nil }

        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear

        return UITargetedPreview(view: cell.logoImageView, parameters: parameters)
    }
    
    func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return getTargetedPreview(for: configuration)
    }

    func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return getTargetedPreview(for: configuration)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: indexPath.row as NSCopying,
            previewProvider: nil) { _ -> UIMenu? in
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


internal final class MyTableCell: UITableViewCell {
    internal let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo1"))
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        logoImageView.anchorSize(to: CGSize(width: 32, height: 32))
        let stackView = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    func bind(text: String) {
        titleLabel.text = text
    }
    
}
