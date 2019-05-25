//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

final class HourlyForecastCollectionCell: BaseCollectionCell<HourlyForecastCollectionCell.Model> {
    private let appearance = Appearance()
    
    private let dateLabel = setup(UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular13
    }
    
    private let temperatureLabel = setup(UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular13
    }
    
    private let iconImageView = setup(UIImageView()) {
        $0.tintColor = Color.white
    }
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubviews(
            dateLabel,
            iconImageView,
            temperatureLabel
        )
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
//            make.leading.greaterThanOrEqualToSuperview()
//            make.trailing.lessThanOrEqualToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(appearance.verticalSpacing)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
//            make.leading.greaterThanOrEqualToSuperview()
//            make.trailing.lessThanOrEqualToSuperview()
            make.size.equalTo(appearance.iconSize)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(appearance.verticalSpacing)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
//            make.leading.greaterThanOrEqualToSuperview()
//            make.trailing.lessThanOrEqualToSuperview()
//            make.bottom.equalToSuperview()
        }
    }
    
    override func update(model: HourlyForecastCollectionCell.Model) {
        dateLabel.text = model.dateString
        temperatureLabel.text = model.temperatureString
        iconImageView.image = model.iconImage.withRenderingMode(.alwaysTemplate)
    }
}

extension HourlyForecastCollectionCell {
    struct Model: CollectionCellProviderConvertible {
        // TODO: Add tint color
        let dateString: String
        let temperatureString: String
        let iconImage: UIImage
        
        var provider: CollectionCellProvider {
            return GenericCollectionCellProvider<Model, HourlyForecastCollectionCell>(model: self)
        }
    }
}

private extension HourlyForecastCollectionCell {
    struct Appearance {
        let iconSize = CGSize(edge: 24)
        let verticalSpacing: CGFloat = 4
    }
}
