//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import Foundation

func make<Type>(_ object: Type, setup: (Type) -> Void) -> Type {
    setup(object)
    return object
}
