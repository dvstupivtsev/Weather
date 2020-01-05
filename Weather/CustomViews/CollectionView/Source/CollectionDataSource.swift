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
        sources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sources[section].providerConvertibles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sources[indexPath.section]
            .providerConvertibles[indexPath.item]
            .provider
            .cell(for: collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectionBehavior.shouldSelect(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectionBehavior.select(at: indexPath)
    }
}

extension CollectionDataSource {
    static var empty: CollectionDataSource {
        CollectionDataSource(sources: [], selectionBehavior: DisabledCollectionSelectionBehavior())
    }
}
