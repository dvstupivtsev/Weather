//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import UIKit
import SnapKit

// TODO: Add reload view if smth went wrong, add Pull2Refresh for reloading data, add skeleton loading
final class CitiesView: BaseView {
    private let appearance = Appearance()
    
    private let tableView = make(UITableView()) {
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
        tableView.contentInset = appearance.margins
        
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func register(cellTypes: [UITableViewCell.Type]) {
        cellTypes.forEach { tableView.register(type: $0) }
    }
    
    func update(tableSource: TableDataSource) {
        tableView.delegate = tableSource
        tableView.dataSource = tableSource
        
        tableView.reloadData()
    }
}

private extension CitiesView {
    struct Appearance {
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
    }
}
