//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(type: T.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewCell>(for tableView: UITableView, at indexPath: IndexPath) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Invalid type for reuse id: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
