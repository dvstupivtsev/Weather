//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import UIKit
import SnapKit

final class CitySearchView: BaseView {
    private let headerView = CitySearchHeaderView()
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        backgroundColor = Color.white
        
        addSubview(headerView)
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    func setupCloseAction(_ action: Action?) {
        headerView.setupCloseAction(action)
    }
    
    func setupTextFieldBehavior(_ behavior: TextFieldBehavior) {
        headerView.setupTextFieldBehavior(behavior)
    }
}
