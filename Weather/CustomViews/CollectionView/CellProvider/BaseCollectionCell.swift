//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

class BaseCollectionCell<Model>: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
