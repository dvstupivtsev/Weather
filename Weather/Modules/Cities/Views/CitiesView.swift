//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import UIKit

final class CitiesView: BaseView {
    private let tableView = make(object: UITableView()) {
        $0.backgroundColor = .white
        $0.tableFooterView = UIView()
        $0.separatorStyle = .none
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
