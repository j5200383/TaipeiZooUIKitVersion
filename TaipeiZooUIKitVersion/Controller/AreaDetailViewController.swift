//
//  AreaDetailViewController.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/13.
//

import UIKit
import Combine

class AreaDetailViewController: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var reuseIdentifier = "Cell"
    var viewModel = AreaDetailViewModel()
    var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
        viewModel.getData()
    }

    private func setUI() {
        setTableView()
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.register(AreaDetailTableViewCell.self)
        tableView.register(UITableViewCell.self)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFLOAT_MIN))

        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
    
    private func binding() {
        viewModel.$animalInfos
            .receive(on: RunLoop.main)
            .sink {[weak self] data in
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return "動物資料"
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView")
        headerView?.contentView.backgroundColor = .gray
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        }
        return 0
    }
}

extension AreaDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.animalInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.reuse(AreaDetailTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.setData(viewModel.areaInfo)
            return cell
        } else {
            let cell = tableView.reuse(UITableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            
            var content = cell.defaultContentConfiguration()
            let data = viewModel.animalInfos[indexPath.row]
            content.text = data.name
            content.secondaryText = data.alsoknown
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
}
