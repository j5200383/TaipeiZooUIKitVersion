//
//  AreaViewController.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/12.
//

import UIKit
import Combine

class AreaViewController: BaseViewController {
    private var tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<ZooAreaInfoSection, ZooAreaInfo>?
    var viewModel = AreaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
        viewModel.getData()
    }
    
    private func setUI() {
        setNavigation()
        setTableView()
        setDataSource()
    }

    private func setNavigation() {
        title = "台北市立動物園"
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self)
        tableView.delegate = self
        
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
    
    private func setDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.reuse(UITableViewCell.self, for: indexPath)
            var content = cell.defaultContentConfiguration()
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            
            content.text = itemIdentifier.name
            content.secondaryText = itemIdentifier.info
            content.secondaryTextProperties.numberOfLines = 2
            content.image = itemIdentifier.image
            content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        
            if let image = itemIdentifier.image {
                content.image = image
            } else {
                self.viewModel.getUrlImage(itemIdentifier.picUrl, index: indexPath.row)
            }
            
            cell.contentConfiguration = content
            return cell
        })
        
        dataSource?.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }
    
    private func binding() {
        viewModel.$zooAreaInfos
            .receive(on: RunLoop.main)
            .sink {[weak self] data in
                self?.applySnapshot()
            }
            .store(in: &cancellable)
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ZooAreaInfoSection, ZooAreaInfo>()
        snapshot.appendSections([.zooArea])
        snapshot.appendItems(viewModel.zooAreaInfos, toSection: .zooArea)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func reloadItems(data: [ZooAreaInfo]) {
        guard var updatedSnapshot = dataSource?.snapshot() else {return}
        updatedSnapshot.reloadItems(data)
        dataSource?.apply(updatedSnapshot, animatingDifferences: true)
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
