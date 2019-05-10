//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit

final class CityWeatherView: BaseView {
    private let backgroundView = DayBackgroundView()
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
