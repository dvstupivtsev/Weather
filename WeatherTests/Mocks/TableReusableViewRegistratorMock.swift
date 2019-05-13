//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import UIKit
@testable import Weather

final class TableReusableViewRegistratorMock: TableReusableViewRegistrator {
    
    //MARK: - register<T: UITableViewCell>
    
    var registerTypeCallsCount = 0
    var registerTypeReceivedType: UITableViewCell.Type?
    var registerTypeClosure: ((UITableViewCell.Type) -> Void)?
    
    func register<T: UITableViewCell>(type: T.Type) {
        registerTypeCallsCount += 1
        registerTypeReceivedType = type
        registerTypeClosure?(type)
    }
    
}
