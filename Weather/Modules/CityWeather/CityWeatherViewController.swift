//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit
import Weakify

final class CityWeatherViewController: BaseViewController<CityWeatherView> {
    private let viewModel: CityWeatherViewModel
    private var dailyForecastSource: TableDataSource = .empty
    private var hourlyForecastSource: CollectionDataSource = .empty
    
    init(viewModel: CityWeatherViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.registerHourlyForecastViews(with: HourlyForecastReusableViewRegistrationDirector())
        customView.registerDailyForecastViews(with: DailyForecastReusableViewRegistrationDirector())
        
        customView.update(mainSource: viewModel.mainSource)
        
        viewModel.getForecastSource()
            .then(weakify(self, type(of: self).updateForecast(with:)))
            .catch { [weak self] _ in
                self?.updateForecast(with: .init(hourlyProviderConvertibles: [], dailyProviderConvertibles: []))
            }
    }
    
    private func updateForecast(with viewSource: CityWeatherViewSource.Forecast) {
        updateHourlyForecast(with: viewSource.hourlyProviderConvertibles)
        updateDailyForecast(with: viewSource.dailyProviderConvertibles)
    }
    
    private func updateDailyForecast(with providerConvertibles: [CellProviderConvertible]) {
        let sectionSource = TableSectionSource(
            cellProviderConvertibles: providerConvertibles
        )
        
        dailyForecastSource = TableDataSource(
            sources: [sectionSource],
            selectionBehavior: DisabledCellSelectionBehavior()
        )
        
        customView.update(dailyForecastSource: dailyForecastSource)
    }
    
    private func updateHourlyForecast(with providerConvertibles: [CollectionCellProviderConvertible]) {
        let sectionSource = CollectionSectionSource(
            providerConvertibles: providerConvertibles
        )
        
        hourlyForecastSource = CollectionDataSource(
            sources: [sectionSource],
            selectionBehavior: DisabledCollectionSelectionBehavior()
        )
        
        customView.update(hourlyForecastSource: hourlyForecastSource)
    }
}
