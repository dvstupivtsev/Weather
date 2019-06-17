//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

// TODO: present error
// sourcery: AutoMockable
protocol CitiesViewUpdatable: AnyObject, LoadingPresentable {
    func update(viewSource: CitiesViewSource)
}
