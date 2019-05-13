//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit
import SnapKit

final class DailyForecastView: BaseView {
    private let appearance = Appearance()
    
    private let tableView = make(UITableView()) {
        $0.tableFooterView = UIView()
        $0.separatorStyle = .none
        $0.backgroundColor = Color.clear
    }
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        backgroundColor = Color.white
        
        tableView.contentInset = appearance.margins
        
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners([.topLeft, .topRight], radius: appearance.cornerRadius)
    }
    
    func registerViews(with registrationDirector: TableReusableViewRegistrationDirector) {
        registrationDirector.registerViews(using: tableView)
    }
    
    func update(tableSource: TableDataSource) {
        tableView.dataSource = tableSource
        tableView.delegate = tableSource
        
        tableView.reloadData()
    }
}

private extension DailyForecastView {
    struct Appearance {
        let margins = UIEdgeInsets(horizontal: 0, vertical: 8)
        let cornerRadius: CGFloat = 16
    }
}
