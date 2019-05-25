//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import UIKit
import SnapKit

final class HourlyForecastView: BaseView {
    private lazy var collectionView = setup(UICollectionView(frame: .zero, collectionViewLayout: LineLayout())) {
        $0.backgroundColor = Color.clear
        $0.showsHorizontalScrollIndicator = false
    }
    
    override func commonInit() {
        super.commonInit()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func registerViews(with registrationDirector: CollectionReusableViewRegistrationDirector) {
        registrationDirector.registerViews(using: collectionView)
    }
    
    func update(collectionSource: CollectionDataSource) {
        collectionView.dataSource = collectionSource
        collectionView.delegate = collectionSource
        
        collectionView.reloadData()
    }
}
