//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit
import SnapKit

final class CityWeatherView: BaseView {
    private let appearance = Appearance()
    
    private let titleLabel = make(UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular17
    }
    
    private let temperatureLabel = make(UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular90
    }
    
    private let degreeLabel = make(UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular90
    }
    
    private let weatherStatusLabel = make(UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular15
    }
    
    private let dateLabel = make(UILabel()) {
        $0.textColor = Color.white
        $0.font = Font.regular11
    }
    
    private let hourlyForecastView = HourlyForecastView()
    private let dailyForecastView = DailyForecastView()
    
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
            hourlyForecastView,
            dailyForecastView
        )
        
        // TODO: test data, should be removed
        hourlyForecastView.backgroundColor = Color.white
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
        
        hourlyForecastView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(appearance.hourlyForecastToDateTopOffset)
            make.height.equalTo(appearance.hourlyForecastHeight)
            make.leading.trailing.equalToSuperview()
        }
        
        dailyForecastView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(hourlyForecastView.snp.bottom).offset(appearance.dailyForecastToHourlyForecastTopOffset)
        }
    }
}

extension CityWeatherView {
    func registerDailyForecastCellsClasses(classes: [UITableViewCell.Type]) {
        dailyForecastView.register(cellsClasses: classes)
    }
    
    func update(mainSource: CityWeatherViewSource.Main) {
        titleLabel.text = mainSource.cityName
        temperatureLabel.text = mainSource.temperatue
        degreeLabel.text = mainSource.degreeSymbol
        weatherStatusLabel.text = mainSource.weatherStatus
        dateLabel.text = mainSource.dateString
    }
    
    func update(dailyForecastSource: TableDataSource) {
        dailyForecastView.update(tableSource: dailyForecastSource)
    }
}

private extension CityWeatherView {
    struct Appearance {
        let titleTopOffset: CGFloat = 20
        let temperatureToTitleTopOffset: CGFloat = 25
        let weatherStatusToTemperatureTopOffset: CGFloat = 15
        let dateToWeatherStatusTopOffset: CGFloat = 8
        let hourlyForecastToDateTopOffset: CGFloat = 30
        let hourlyForecastHeight: CGFloat = 64
        let dailyForecastToHourlyForecastTopOffset: CGFloat = 20
    }
}
