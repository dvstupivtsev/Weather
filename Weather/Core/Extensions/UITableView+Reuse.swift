//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

extension UITableView: TableReusableViewRegistrator {
    func register<T: UITableViewCell>(type: T.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
}

extension UITableView {
    func dequeue<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Invalid type for reuse id: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
