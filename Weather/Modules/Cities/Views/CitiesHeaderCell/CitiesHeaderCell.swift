//
//  Created by Dmitriy Stupivtsev on 04/05/2019.
//

import UIKit
import SnapKit

final class CitiesHeaderCell: BaseCell {
    private let appearance = Appearance()
    
    private let titleLabel = make(object: UILabel()) {
        $0.font = Font.regular30
        $0.textColor = Color.white
    }
    
    private let addButton = make(object: UIButton()) {
        $0.imageView?.tintColor = Color.white
        $0.setImage(Assets.add.image.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
    }
    
    private var onAddAction: Action?
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubviews(titleLabel, addButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(appearance.margins)
            make.top.equalTo(contentView.snp.topMargin).offset(appearance.titleTopMargin)
            make.trailing.lessThanOrEqualTo(addButton.snp.leading).offset(-appearance.titleToButtonSpacing)
        }
        
        addButton.snp.makeConstraints { make in
            make.size.equalTo(appearance.addButtonSize)
            make.bottom.trailing.equalTo(appearance.margins)
        }
    }
    
    @objc
    private func handleAdd() {
        onAddAction?()
    }
}

extension CitiesHeaderCell {
    func update(model: Model) {
        titleLabel.text = model.title
        onAddAction = model.onAddAction
    }
    
    struct Model: CellProviderConvertible {
        let title: String
        let onAddAction: Action
        
        var cellProvider: CellProvider {
            return CitiesHeaderCellProvider(model: self)
        }
    }
}

private extension CitiesHeaderCell {
    struct Appearance {
        let margins = UIEdgeInsets(all: 12)
        let titleTopMargin: CGFloat = 20
        let titleToButtonSpacing: CGFloat = 8
        let addButtonSize = CGSize(edge: 30)
    }
}
