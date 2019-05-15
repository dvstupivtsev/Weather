//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import Foundation
import Promises

final class CitySearchViewModelImpl: CitySearchViewModel {
    private let viewUpdatable: CitySearchViewUpdatable
    
    var textEditingDelegate: TextEditingDelegate {
        return self
    }
    
    init(viewUpdatable: CitySearchViewUpdatable) {
        self.viewUpdatable = viewUpdatable
    }
}

extension CitySearchViewModelImpl: TextEditingDelegate {
    func didChangeText(_ text: String?) {
        getCities(for: text ?? "")
            .then(viewUpdatable.update(providerConvertibles:))
            .catch { [weak self] _ in
                self?.viewUpdatable.update(providerConvertibles: [])
            }
    }
    
    private func getCities(for name: String) -> Promise<[CellProviderConvertible]> {
        return Promise([])
    }
}
