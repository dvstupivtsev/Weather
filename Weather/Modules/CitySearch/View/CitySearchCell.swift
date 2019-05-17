//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import UIKit
import SnapKit

final class CitySearchCell: BaseCell<CitySearchCell.Model> {
    private let appearance = Appearance()
    
    private let titleLabel = make(UILabel()) {
        $0.font = Font.regular17
        $0.textColor = Color.black
    }
    
    private let separatorView = SeparatorView()
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubviews(titleLabel, separatorView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(appearance.margins)
            make.trailing.lessThanOrEqualTo(appearance.margins)
            make.bottom.equalTo(separatorView.snp.top).offset(-appearance.margins.bottom)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview()
            make.trailing.equalTo(snp.trailing)
        }
    }
    
    override func update(model: CitySearchCell.Model) {
        titleLabel.text = model.title
    }
}

extension CitySearchCell {
    struct Model: CellProviderConvertible {
        let title: String
        
        var cellProvider: CellProvider {
            return GenericCellProvider<Model, CitySearchCell>(model: self)
        }
    }
}

private extension CitySearchCell {
    struct Appearance {
        let margins = UIEdgeInsets(all: 12)
    }
}
