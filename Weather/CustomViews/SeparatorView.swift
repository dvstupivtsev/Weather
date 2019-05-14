//
//  Created by Dmitriy Stupivtsev on 14/05/2019.
//

import UIKit
import SnapKit

final class SeparatorView: BaseView {
    private let height = 1.0 / UIScreen.main.scale
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        backgroundColor = Color.black10
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
}
