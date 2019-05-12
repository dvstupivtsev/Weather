//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

protocol CollectionCellProvider {
    func cell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
}
