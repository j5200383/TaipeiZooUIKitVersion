//
//  AreaViewController.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/12.
//

import UIKit
import Combine

class AreaViewController: UIViewController {
    private var tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<ZooAreaInfoSection, ZooAreaInfo>?
    var cancellable = Set<AnyCancellable>()
    var viewModel = AreaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
        viewModel.getData()
        
//        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
//            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
//            var content = cell.defaultContentConfiguration()
//            cell.selectionStyle = .none
//            cell.accessoryType = .disclosureIndicator
//
//            content.text = itemIdentifier.name
//            content.secondaryText = itemIdentifier.info
//            content.secondaryTextProperties.numberOfLines = 2
//            content.image = itemIdentifier.image
//            content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
//            ImageManager.shared.fetchImage(url: URL(string: itemIdentifier.picUrl)!) { image in
//                DispatchQueue.main.async {
//                    let updatedSnapshot = self.dataSource?.snapshot()
//                    self.viewModel.zooAreaInfos[indexPath.row].image = image
//                    self.dataSource?.apply(updatedSnapshot!, animatingDifferences: true)
//                }
//            }
//
//            cell.contentConfiguration = content
//            return cell
//        })
    }
    
    private func setUI() {
        setNavigation()
        setTableView()
    }

    private func setNavigation() {
        title = "台北市立動物園"
        navigationItem.backButtonDisplayMode = .minimal
        
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self)
        //        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
    
    private func binding() {
        viewModel.$zooAreaInfos
            .receive(on: RunLoop.main)
            .sink {[weak self] data in
                self?.tableView.reloadData()
//                let test = ZooAreaInfo(name: "測試", picUrl: "", info: "安安")
//
//                var snapshot = NSDiffableDataSourceSnapshot<ZooAreaInfoSection, ZooAreaInfo>()
//                snapshot.appendSections([.zooArea, .zoo])
//                snapshot.appendItems(data, toSection: .zooArea)
//                snapshot.appendItems([test], toSection: .zoo)
//                self?.dataSource?.apply(snapshot, animatingDifferences: true)

            }
            .store(in: &cancellable)
    }
}

extension AreaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AreaDetailViewController()
        let detailViewModel = AreaDetailViewModel()
        let data = viewModel.zooAreaInfos[indexPath.row]
        detailViewModel.areaInfo = data
        controller.title = data.name
        controller.viewModel = detailViewModel 
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension AreaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.zooAreaInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(UITableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        var content = cell.defaultContentConfiguration()
        let data = viewModel.zooAreaInfos[indexPath.row]
        content.text = data.name
        content.secondaryText = data.info
        content.secondaryTextProperties.numberOfLines = 2
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        
        if let image = data.image {
            content.image = image
        } else {
            viewModel.getUrlImage(data.picUrl, index: indexPath.row)
        }

        cell.contentConfiguration = content
        return cell
    }
}

