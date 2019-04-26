//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

typealias Handler<Type> = (Type) -> Void
typealias ResultHandler<Type> = Handler<Result<Type, Error>>
