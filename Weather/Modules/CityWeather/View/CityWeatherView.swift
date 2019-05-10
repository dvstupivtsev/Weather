//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit
import SnapKit

final class CityWeatherView: BaseView {
    private let longTermForecastView = LongTermForecastView()
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(longTermForecastView)
    }
    
    private func setupConstraints() {
        longTermForecastView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(snp.centerY)
        }
    }
}
