//
//  Created by Dmitriy Stupivtsev on 14/05/2019.
//

import UIKit
import SnapKit

final class ViewContainer<Type: UIView>: BaseView {
    let contained: Type
    
    init(contained: Type, insets: UIEdgeInsets) {
        self.contained = contained
        
        super.init(frame: .zero)
        
        addSubview(contained)
        contained.snp.makeConstraints { make in
            make.edges.equalTo(insets)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}
