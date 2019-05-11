//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import UIKit
import SnapKit

final class DailyForecastCell: BaseCell<DailyForecastCell.Model> {
    override func update(model: DailyForecastCell.Model) {
        
    }
}

extension DailyForecastCell {
    struct Model: CellProviderConvertible {
        var cellProvider: CellProvider {
            return GenericCellProvider<Model, DailyForecastCell>(model: self)
        }
    }
}
