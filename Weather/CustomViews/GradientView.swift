//
//  Created by Dmitriy Stupivtsev on 03/05/2019.
//

import UIKit

final class GradientView: BaseView {
    private let gradientLayer = CAGradientLayer()
    init(colors: [UIColor]) {
        super.init(frame: .zero)
        
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = colors.enumerated().map { (index, _) in
            let location = 1.0 / Double(colors.count) * Double(index + 1)
            return NSNumber(value: location)
        }
        
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
}
