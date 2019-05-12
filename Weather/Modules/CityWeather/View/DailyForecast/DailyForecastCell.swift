//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import UIKit
import SnapKit

// TODO: Rename to DailyForecastTableCell
final class DailyForecastCell: BaseCell<DailyForecastCell.Model> {
    private let appearance = Appearance()
    
    private let weekdayLabel = make(UILabel()) {
        $0.font = Font.regular17
        $0.textColor = Color.black
    }
    
    private let dateLabel = make(UILabel()) {
        $0.font = Font.regular13
        $0.textColor = Color.black50
    }
    
    private let maxTempLabel = make(UILabel()) {
        $0.font = Font.regular17
        $0.textColor = Color.black
    }
    
    private let minTempLabel = make(UILabel()) {
        $0.font = Font.regular15
        $0.textColor = Color.black50
    }
    
    private let weatherImageView = make(UIImageView()) {
        $0.tintColor = Color.black50
    }
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubviews(
            weekdayLabel,
            dateLabel,
            maxTempLabel,
            minTempLabel,
            weatherImageView
        )
    }
    
    private func setupConstraints() {
        weekdayLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(appearance.margins)
            make.top.equalTo(dateLabel.snp.bottom).offset(appearance.dateWithWeekdaySpacing)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(appearance.margins)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(appearance.margins)
            make.leading.equalTo(maxTempLabel.snp.centerX).offset(appearance.minTempLeadingWithMaxTempCenterXSpacing)
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.size.equalTo(appearance.imageSize)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-appearance.imageTrailingMarginWithSuperview)
        }
    }
    
    override func update(model: DailyForecastCell.Model) {
        weekdayLabel.text = model.weekdayTitle
        dateLabel.text = model.dateString
        maxTempLabel.text = model.maxTemperatureString
        minTempLabel.text = model.minTemperatureString
        weatherImageView.image = model.weatherImage.withRenderingMode(.alwaysTemplate)
    }
}

extension DailyForecastCell {
    struct Model: CellProviderConvertible {
        let weekdayTitle: String
        let dateString: String
        let weatherImage: UIImage
        let maxTemperatureString: String
        let minTemperatureString: String
        
        var cellProvider: CellProvider {
            return GenericCellProvider<Model, DailyForecastCell>(model: self)
        }
    }
}

private extension DailyForecastCell {
    struct Appearance {
        let margins = UIEdgeInsets(all: 12)
        let dateWithWeekdaySpacing: CGFloat = 4
        let minTempLeadingWithMaxTempCenterXSpacing: CGFloat = 24
        let imageTrailingMarginWithSuperview: CGFloat = 90
        let imageSize = CGSize(edge: 24)
    }
}
