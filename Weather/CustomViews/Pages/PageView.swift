//
//  Created by Dmitriy Stupivtsev on 05/05/2019.
//

import UIKit
import SnapKit

final class PageView: BaseView {
    private let appearance = Appearance()
    
    private var backgroundView: UIView?
    private let pageControl = setup(UIPageControl()) {
        $0.isUserInteractionEnabled = false
    }
    
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
    
    func addPageView(_ view: UIView) {
        insertFirst(subview: view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func showPagesIndicator() {
        pageControl.isHidden = false
    }
    
    func hidePagesIndicator() {
        pageControl.isHidden = true
    }
}

private extension PageView {
    struct Appearance {
        let pageControlMargins = UIEdgeInsets(all: 8)
    }
}
