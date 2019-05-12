//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

// TODO: Rename to BaseTableCell
class BaseCell<Model>: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = Color.clear
    }
    
    func update(model: Model) { }
}
