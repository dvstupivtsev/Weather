//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import Foundation

func setup<Type>(_ object: Type, block: (Type) -> Void) -> Type {
    block(object)
    return object
}
