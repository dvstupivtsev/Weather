//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

protocol CollectionReusableViewRegistrator {
    func register<T: UICollectionViewCell>(type: T.Type)
}
