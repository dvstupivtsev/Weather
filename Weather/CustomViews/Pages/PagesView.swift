//
//  Created by Dmitriy Stupivtsev on 05/05/2019.
//

import UIKit
import SnapKit

final class PagesView: BaseView {
    private let appearance = Appearance()
    
    private let pageControl = UIPageControl()
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(pageControl)
    }
    
    private func setupConstraints() {
        pageControl.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(appearance.pageControlMargins)
        }
    }
    
    func setPagesCount(_ count: Int) {
        pageControl.numberOfPages = count
    }
    
    func setCurrentPageIndex(_ index: Int) {
        pageControl.currentPage = index
    }
    
    func addPagesView(_ view: UIView) {
        insertFirst(subview: view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

private extension PagesView {
    struct Appearance {
        let pageControlMargins = UIEdgeInsets(all: 8)
    }
}
