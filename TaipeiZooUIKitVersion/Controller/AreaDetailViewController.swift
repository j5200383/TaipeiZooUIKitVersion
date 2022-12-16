//
//  AreaDetailViewController.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/13.
//

import UIKit
import Combine

class AreaDetailViewController: BaseViewController {
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var dataSource: UITableViewDiffableDataSource<AnimalSectionType, AnyHashable>?
    var viewModel = AreaDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
        viewModel.getData()
    }

    private func setUI() {
        navigationItem.backButtonDisplayMode = .minimal
        setTableView()
        setDataSource()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.register(AreaDetailTableViewCell.self)
        tableView.register(UITableViewCell.self)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "FooterView")
        tableView.delegate = self
//        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFLOAT_MIN))

        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
    
    private func setDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            if let zooAreaInfo = itemIdentifier as? ZooAreaInfo {
                let cell = tableView.reuse(AreaDetailTableViewCell.self, for: indexPath)
                cell.setData(zooAreaInfo)
                return cell
            } else if let animalInfo = itemIdentifier as? AnimalInfo {
                let cell = tableView.reuse(UITableViewCell.self, for: indexPath)
                cell.selectionStyle = .none
                cell.accessoryType = .disclosureIndicator
                
                var content = cell.defaultContentConfiguration()
                content.text = animalInfo.name
                content.secondaryText = animalInfo.alsoknown
                content.secondaryTextProperties.numberOfLines = 2
                content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
                
                if let image = animalInfo.image {
                    content.image = image
                } else {
                    self.viewModel.getUrlImage(animalInfo.picUrl, index: indexPath.row)
                }

                cell.contentConfiguration = content
                return cell
            }
            return UITableViewCell()
        }
        
        dataSource?.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }
    
    private func binding() {
        viewModel.$animalInfos
            .receive(on: RunLoop.main)
            .sink {[weak self] data in
                self?.applySnapshot()
            }
            .store(in: &cancellable)
        
        viewModel.$loadingEven
            .receive(on: RunLoop.main)
            .sink {[weak self] loadingEven in
                switch loadingEven {
                case .loading:
                    self?.startLoadingView()
                case .stop:
                    self?.stopLoadingView()
                }
            }
            .store(in: &cancellable)
        
        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink {[weak self] message in
                guard let message = message else {return}
                self?.showAlert(message: message)
            }
            .store(in: &cancellable)
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<AnimalSectionType, AnyHashable>()
        snapshot.appendSections([.zooAreaInfo, .animalInfo])
        snapshot.appendItems([viewModel.areaInfo!], toSection: .zooAreaInfo)
        snapshot.appendItems(viewModel.animalInfos, toSection: .animalInfo)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension AreaDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {return}
        
        let controller = AnimalDetatilViewController()
        let data = viewModel.animalInfos[indexPath.row]
        controller.setData(data)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView")
        var content = headerView?.defaultContentConfiguration()
        content?.text = "動物資料"
        headerView?.contentConfiguration = content
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterView")
        footerView?.contentView.backgroundColor = .systemGray2
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
}
