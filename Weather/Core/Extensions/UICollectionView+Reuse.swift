//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

extension UICollectionView: CollectionReusableViewRegistrator {
    func register<T: UICollectionViewCell>(type: T.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
}

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Invalid type for reuse id: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
