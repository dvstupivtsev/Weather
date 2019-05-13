//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import UIKit
@testable import Weather

final class CollectionReusableViewRegistratorMock: CollectionReusableViewRegistrator {
    
    //MARK: - register<T: UICollectionViewCell>
    
    var registerTypeCallsCount = 0
    var registerTypeReceivedType: UICollectionViewCell.Type?
    var registerTypeClosure: ((UICollectionViewCell.Type) -> Void)?
    
    func register<T: UICollectionViewCell>(type: T.Type) {
        registerTypeCallsCount += 1
        registerTypeReceivedType = type
        registerTypeClosure?(type)
    }
    
}
