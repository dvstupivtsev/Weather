//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

struct HourlyForecastReusableViewRegistrator: CollectionReusableViewRegistrator {
    func registerViews(for collectionView: UICollectionView) {
        collectionView.register(type: HourlyForecastCollectionCell.self)
    }
}
