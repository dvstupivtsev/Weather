//
//  Created by Dmitriy Stupivtsev on 14/05/2019.
//

import UIKit
import SnapKit

final class CitySearchHeaderView: BaseView {
    private let appearance = Appearance()
    
    private var textFieldBehavior: TextFieldBehavior?
    
    private lazy var searchImageContainer = ViewContainer(
        contained: make(UIImageView()) {
            $0.tintColor = Color.black
            $0.image = Assets.search.image.withRenderingMode(.alwaysTemplate)
        },
        insets: appearance.searchImageInsets
    )
    
    private lazy var searchTextField = make(UITextField()) {
        $0.textColor = Color.black
        $0.tintColor = Color.black50
        $0.placeholder = L10n.CitySearch.searchPlaceholder
        $0.leftView = searchImageContainer
        $0.rightView = clearButton
        $0.leftViewMode = .always
        $0.rightViewMode = .whileEditing
    }
    
    private lazy var clearButton = make(UIButton(type: .system)) {
        $0.tintColor = Color.black
        $0.setImage(Assets.clear.image.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.contentEdgeInsets = appearance.clearButtonInsets
    }
    
    private let closeButton = make(UIButton(type: .system)) {
        $0.tintColor = Color.black
        $0.titleLabel?.font = Font.regular17
        $0.setTitle(L10n.close, for: .normal)
    }
    
    private let separatorView = SeparatorView()
    
    private var onClose: Action?
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        backgroundColor = Color.white
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        addSubviews(
            searchTextField,
            closeButton,
            separatorView
        )
        
        layer.masksToBounds = false
        layer.shadowColor = Color.black.cgColor
        layer.shadowOpacity = appearance.shadow.opacity
        layer.shadowRadius = appearance.shadow.shadowRadius
        layer.shadowOffset = appearance.shadow.shadowOffset
    }
    
    private func setupConstraints() {
        searchImageContainer.frame = CGRect(origin: .zero, size: appearance.searchImageSize)
        clearButton.frame = CGRect(origin: .zero, size: appearance.clearButtonSize)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).offset(appearance.margins.top)
            make.leading.equalTo(appearance.margins)
            make.height.equalTo(appearance.searchTextFieldHeight)
            make.trailing.equalTo(closeButton.snp.leading).offset(-appearance.searchTextFieldToCloseButtonSpacing)
            make.bottom.equalTo(separatorView.snp.top).offset(-appearance.margins.bottom)
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalTo(appearance.margins)
            make.centerY.equalTo(searchTextField)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func close() {
        onClose?()
    }
    
    func setupCloseAction(_ action: Action?) {
        onClose = action
    }
    
    func setupTextFieldBehavior(_ behavior: TextFieldBehavior) {
        self.textFieldBehavior = behavior
        behavior.setup(textField: searchTextField)
    }
}

private extension CitySearchHeaderView {
    struct Appearance {
        struct Shadow {
            let opacity: Float = 0.15
            let shadowRadius: CGFloat = 10
            let shadowOffset = CGSize(width: 0, height: 5)
        }
        
        let shadow = Shadow()
        let margins = UIEdgeInsets(horizontal: 12, vertical: 4)
        let clearButtonSize = CGSize(edge: 30)
        let clearButtonInsets = UIEdgeInsets(all: 6)
        let searchTextFieldHeight: CGFloat = 30
        let searchImageSize = CGSize(width: 34, height: 24)
        let searchImageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        let searchTextFieldToCloseButtonSpacing: CGFloat = 8
    }
}
