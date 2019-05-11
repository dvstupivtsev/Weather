//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import UIKit

final class TableDataSource: NSObject & UITableViewDataSource & UITableViewDelegate {
    private let sources: [TableSectionSource]
    private let selectionBehavior: CellSelectionBehavior
    
    init(sources: [TableSectionSource], selectionBehavior: CellSelectionBehavior) {
        self.sources = sources
        self.selectionBehavior = selectionBehavior
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources[section].cellProviderConvertibles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sources[indexPath.section]
            .cellProviderConvertibles[indexPath.row]
            .cellProvider
            .cell(for: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return selectionBehavior.shouldSelect(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectionBehavior.select(at: indexPath)
    }
}
