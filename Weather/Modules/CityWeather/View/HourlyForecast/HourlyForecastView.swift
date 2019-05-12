//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import UIKit
import SnapKit

// TODO: Refactor
final class LineLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        self.itemSize = CGSize(width: 30, height: 64)
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsets(horizontal: 12, vertical: 0)
        self.minimumLineSpacing = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizCenter = proposedContentOffset.x + (collectionView?.bounds.size.width ?? 0) / 2
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView?.bounds.size.width ?? 0, height: collectionView?.bounds.size.height ?? 0)
        super.layoutAttributesForElements(in: targetRect)?.forEach {
            let center = $0.center.x
            if abs(center - horizCenter) < abs(offsetAdjustment) {
                offsetAdjustment = center - horizCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}

final class HourlyForecastView: BaseView {
    private lazy var collectionView = make(UICollectionView(frame: .zero, collectionViewLayout: LineLayout())) {
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
    
    func registerViews(with registrator: CollectionReusableViewRegistrator) {
        registrator.registerViews(for: collectionView)
    }
    
    func update(collectionSource: CollectionDataSource) {
        collectionView.dataSource = collectionSource
        collectionView.delegate = collectionSource
        
        collectionView.reloadData()
    }
}
