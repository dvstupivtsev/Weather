//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

final class GenericCollectionCellProvider<Model, Cell: BaseCollectionCell<Model>>: CollectionCellProvider {
    private let model: Model
    
    init(model: Model) {
        self.model = model
    }
    
    func cell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeue(at: indexPath)
        cell.update(model: model)
        
        return cell
    }
}
