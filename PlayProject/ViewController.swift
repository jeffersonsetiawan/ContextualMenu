//
//  ViewController.swift
//  PlayProject
//
//  Created by Jefferson Setiawan on 12/02/20.
//  Copyright © 2020 Jefferson Setiawan. All rights reserved.
//

import UIKit

internal class ViewController: UIViewController {
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        return view
    }()

    private let cellIdentifier = "cellIdentifier"

    internal override func viewDidLoad() {
        super.viewDidLoad()
        title = "Context Menu"
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Static"
        case 1:
            cell.textLabel?.text = "Table"
        case 2:
            cell.textLabel?.text = "Collection View"
        case 3:
            cell.textLabel?.text = "IGListKit"
        case 4:
            cell.textLabel?.text = "Texture"
        case 5:
            cell.textLabel?.text = "Texture With IGListKit ❌"
        default:
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(StaticVC(), animated: true)
            break
        case 1:
            navigationController?
                .pushViewController(TableVC(), animated: true)
        case 2:
            navigationController?
                .pushViewController(CollectionVC(), animated: true)
        case 3:
            navigationController?
                .pushViewController(IGVC(), animated: true)
//        case 4:
//            navigationController?.pushViewController(TextureVC(), animated: true)
//        case 5:
//            navigationController?.pushViewController(TextureIGListKitVC(), animated: true)
        default:
            break
        }
    }
}
