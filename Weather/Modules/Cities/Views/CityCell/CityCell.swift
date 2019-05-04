//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit
import SnapKit

final class CityCell: BaseCell {
    private let appearance = Appearance()
    
    private let titleLabel = make(object: UILabel()) {
        $0.font = Font.regular17
        $0.textColor = Color.white
    }
    
    private let dateLabel = make(object: UILabel()) {
        $0.font = Font.regular15
        $0.textColor = Color.white70
    }
    
    private let temperatureLabel = make(object: UILabel()) {
        $0.font = Font.regular30
        $0.textColor = Color.white
    }
    
    private let weatherImageView = make(object: UIImageView()) {
        $0.tintColor = Color.white
    }
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubviews(
            titleLabel,
            dateLabel,
            temperatureLabel,
            weatherImageView
        )
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(appearance.margins)
            make.leading.equalTo(appearance.margins.left)
            make.bottom.equalTo(contentView.snp.centerY).offset(-appearance.titleCenterOffset)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(appearance.margins.left)
            make.top.equalTo(contentView.snp.centerY).offset(appearance.dateCenterOffset)
            make.bottom.equalTo(appearance.margins)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.trailing.equalTo(weatherImageView.snp.leading).offset(-appearance.iconHorizontalSpacing)
            make.centerY.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-appearance.margins.right)
            make.size.equalTo(appearance.weatherImageViewSize)
            make.centerY.equalToSuperview()
        }
    }
}

extension CityCell {
    func update(model: Model) {
        titleLabel.text = model.title
        dateLabel.text = model.dateTimeString
        temperatureLabel.text = model.temperatureString
        weatherImageView.image = model.weatherIcon?.withRenderingMode(.alwaysTemplate)
    }
    
    struct Model: CellProviderConvertible {
        let title: String
        let dateTimeString: String
        let temperatureString: String
        let weatherIcon: UIImage?
        
        var cellProvider: CellProvider {
            return CityCellProvider(model: self)
        }
    }
}

private extension CityCell {
    struct Appearance {
        let margins = UIEdgeInsets(all: 12)
        let titleCenterOffset: CGFloat = 2
        let dateCenterOffset: CGFloat = 2
        let statusToTemperatureOffset: CGFloat = 4
        let weatherImageViewSize = CGSize(width: 24, height: 24)
        let iconHorizontalSpacing: CGFloat = 4
    }
}
