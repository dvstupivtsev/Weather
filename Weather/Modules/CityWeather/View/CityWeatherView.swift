//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit
import SnapKit

final class CityWeatherView: BaseView {
    private let appearance = Appearance()
    
    private let titleLabel = make(object: UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular17
    }
    
    private let temperatureLabel = make(object: UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular90
    }
    
    private let degreeLabel = make(object: UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular90
        $0.text = "°"
    }
    
    private let weatherStatusLabel = make(object: UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular15
    }
    
    private let dateLabel = make(object: UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular11
    }
    
    private let dayForecastView = DayForecastView()
    private let longTermForecastView = LongTermForecastView()
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubviews(
            titleLabel,
            temperatureLabel,
            degreeLabel,
            weatherStatusLabel,
            dateLabel,
            dayForecastView,
            longTermForecastView
        )
        
        // TODO: test data, should be removed
        titleLabel.text = "SAN FRANCISCO"
        temperatureLabel.text = "8"
        weatherStatusLabel.text = "CLEAR"
        dateLabel.text = "THURSDAY, JANUARY 18"
        dayForecastView.backgroundColor = Color.white
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).offset(appearance.titleTopOffset)
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(appearance.temperatureToTitleTopOffset)
            make.centerX.equalToSuperview()
        }
        
        degreeLabel.snp.makeConstraints { make in
            make.leading.equalTo(temperatureLabel.snp.trailing)
            make.top.equalTo(temperatureLabel)
        }
        
        weatherStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(appearance.weatherStatusToTemperatureTopOffset)
            make.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherStatusLabel.snp.bottom).offset(appearance.dateToWeatherStatusTopOffset)
            make.centerX.equalToSuperview()
        }
        
        dayForecastView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(appearance.dayForecastToDateTopOffset)
            make.height.equalTo(appearance.dayForecastHeight)
            make.leading.trailing.equalToSuperview()
        }
        
        longTermForecastView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(dayForecastView.snp.bottom).offset(appearance.longTermForecastToDayForecastTopOffset)
        }
    }
}

private extension CityWeatherView {
    struct Appearance {
        let titleTopOffset: CGFloat = 20
        let temperatureToTitleTopOffset: CGFloat = 25
        let weatherStatusToTemperatureTopOffset: CGFloat = 15
        let dateToWeatherStatusTopOffset: CGFloat = 8
        let dayForecastToDateTopOffset: CGFloat = 30
        let dayForecastHeight: CGFloat = 64
        let longTermForecastToDayForecastTopOffset: CGFloat = 20
    }
}
