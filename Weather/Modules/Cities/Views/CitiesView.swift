//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import UIKit
import SnapKit

// TODO: Add reload view if smth went wrong, add Pull2Refresh for reloading data, add skeleton loading
final class CitiesView: BaseView {
    private let tableView = make(object: UITableView()) {
        $0.tableFooterView = UIView()
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableDelegate(_ delegate: UITableViewDataSource & UITableViewDelegate) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func register(cellTypes: [UITableViewCell.Type]) {
        cellTypes.forEach { tableView.register(type: $0) }
    }
}
