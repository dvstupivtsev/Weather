//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit
import Weakify

final class CityWeatherViewController: BaseViewController<CityWeatherView> {
    private let viewModel: CityWeatherViewModel
    private var tableSource: TableDataSource = .empty
    
    init(viewModel: CityWeatherViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.update(mainSource: viewModel.mainSource)
        
        viewModel.getDailyForecastSource()
            .then(weakify(self, type(of: self).updateDailyForecast(cellProviderConvertibles:)))
            .catch { [weak self] _ in self?.updateDailyForecast(cellProviderConvertibles: []) }
    }
    
    private func updateDailyForecast(cellProviderConvertibles: [CellProviderConvertible]) {
        let sectionSource = TableSectionSource(cellProviderConvertibles: cellProviderConvertibles)
        tableSource = TableDataSource(
            sources: [sectionSource],
            selectionBehavior: DisabledCellSelectionBehavior()
        )
        
        customView.update(dailyForecastSource: tableSource)
    }
}
