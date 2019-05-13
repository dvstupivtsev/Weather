//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import UIKit

protocol TableReusableViewRegistrator {
    func register<T: UITableViewCell>(type: T.Type)
}
