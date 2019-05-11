//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CityWeatherFactoryImpl: CityWeatherFactory {
    func create(with citySource: CitySource) -> UIViewController {
        let viewModel = CityWeatherViewModelImpl(
            citySource: citySource,
            numberFormatter: NumberFormatter.temperature,
            dateFormatter: DateFormatter.EEEE_MMM_dd
        )
        
        return CityWeatherViewController(viewModel: viewModel)
    }
}

