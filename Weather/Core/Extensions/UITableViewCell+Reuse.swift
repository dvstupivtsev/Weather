//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: type(of: self))
    }
}
