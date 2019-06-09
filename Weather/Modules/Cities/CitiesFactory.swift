//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

final class CitiesFactory {
    func create(router: CitiesRouter, store: Store<[CitySource]>, persistentStore: PersistentStore) -> UIViewController {
        let viewUpdatableProxy = CitiesViewUpdatableProxy()
        
        let vm = CitiesViewModelImpl(
            store: store,
            persistentStore: CitySourcePersistentStore(persistentStore: persistentStore),
            service: CitiesServiceFactory().create(),
            dateFormatter: CitiesDateFormatterImpl(),
            router: router,
            viewUpdatable: viewUpdatableProxy
        )
        
        let vc = CitiesViewController(viewModel: vm)
        viewUpdatableProxy.wrapped = vc
        
        return vc
    }
}
