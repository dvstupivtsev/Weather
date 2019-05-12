//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

final class CollectionDataSource: NSObject & UICollectionViewDataSource & UICollectionViewDelegate {
    private let sources: [CollectionSectionSource]
    private let selectionBehavior: CollectionSelectionBehavior

    init(sources: [CollectionSectionSource], selectionBehavior: CollectionSelectionBehavior) {
        self.sources = sources
        self.selectionBehavior = selectionBehavior
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources[section].providerConvertibles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sources[indexPath.section]
            .providerConvertibles[indexPath.item]
            .provider
            .cell(for: collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return selectionBehavior.shouldSelect(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectionBehavior.select(at: indexPath)
    }
}

extension CollectionDataSource {
    static var empty: CollectionDataSource {
        return CollectionDataSource(sources: [], selectionBehavior: DisabledCollectionSelectionBehavior())
    }
}
