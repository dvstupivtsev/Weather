//
//  Created by Dmitriy Stupivtsev on 14/05/2019.
//

import UIKit
import SnapKit

final class CitySearchHeaderView: BaseView {
    private let appearance = Appearance()
    
    private lazy var closeButton = make(UIButton(type: .system)) {
        $0.setImage(Assets.close.image.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.contentEdgeInsets = appearance.closeButtonInternalInsets
    }
    
    private var onClose: Action?
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        backgroundColor = Color.white
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        addSubview(closeButton)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(appearance.closeButtonExternalInsets)
            make.size.equalTo(appearance.closeButtonSize)
        }
    }
    
    @objc
    private func close() {
        onClose?()
    }
    
    func setupCloseAction(_ action: Action?) {
        onClose = action
    }
}

private extension CitySearchHeaderView {
    struct Appearance {
        let closeButtonSize = CGSize(edge: 44)
        let closeButtonInternalInsets = UIEdgeInsets(all: 12)
        let closeButtonExternalInsets = UIEdgeInsets(horizontal: 8, vertical: 16)
    }
}
