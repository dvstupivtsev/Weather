//
//  Created by Dmitriy Stupivtsev on 04/05/2019.
//

import UIKit
import SnapKit

final class CitiesHeaderTableCell: BaseTableCell<CitiesHeaderTableCell.Model> {
    private let appearance = Appearance()
    
    private let titleLabel = setup(UILabel()) {
        $0.font = Font.regular30
        $0.textColor = Color.white
    }
    
    private let addButton = setup(UIButton()) {
        $0.imageView?.tintColor = Color.white
        $0.setImage(Assets.add.image.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    private var onAddAction: Action?
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        
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
    
    override func update(model: Model) {
        titleLabel.text = model.title
        onAddAction = model.onAddAction
    }
}

extension CitiesHeaderTableCell {
    struct Model: TableCellProviderConvertible {
        let title: String
        let onAddAction: Action
        
        var cellProvider: TableCellProvider {
            return GenericTableCellProvider<Model, CitiesHeaderTableCell>(model: self)
        }
    }
}

private extension CitiesHeaderTableCell {
    struct Appearance {
        let margins = UIEdgeInsets(all: 12)
        let titleTopMargin: CGFloat = 20
        let titleToButtonSpacing: CGFloat = 8
        let addButtonSize = CGSize(edge: 30)
    }
}
