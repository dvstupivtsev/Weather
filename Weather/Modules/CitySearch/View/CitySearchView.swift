//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import UIKit
import SnapKit

final class CitySearchView: BaseView {
    private let headerView = CitySearchHeaderView()
    private let tableView = setup(UITableView()) {
        $0.separatorStyle = .none
        $0.tableFooterView = UIView()
        $0.keyboardDismissMode = .onDrag
    }
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        backgroundColor = Color.white
        
        addSubviews(tableView, headerView)
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    func setupCloseAction(_ action: Action?) {
        headerView.setupCloseAction(action)
    }
    
    func setupTextFieldBehavior(_ behavior: TextFieldBehavior) {
        headerView.setupTextFieldBehavior(behavior)
    }
    
    func registerViews(with director: TableReusableViewRegistrationDirector) {
        director.registerViews(using: tableView)
    }
    
    func update(tableSource: TableDataSource) {
        tableView.delegate = tableSource
        tableView.dataSource = tableSource
        
        tableView.reloadData()
    }
    
    func startSearching() {
        headerView.startSearching()
    }
    
    func stopSearching() {
        headerView.stopSearching()
    }
    
    func updateTableInsets(_ insets: UIEdgeInsets) {
        tableView.contentInset = insets
    }
}
