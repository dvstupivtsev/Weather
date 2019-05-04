//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import UIKit
import SnapKit

final class CitiesView: BaseView {
    private let backgroundView = GradientView(colors: [Color.bg1, Color.bg2, Color.bg3, Color.bg4, Color.bg5])
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
        addSubviews(backgroundView, tableView)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
