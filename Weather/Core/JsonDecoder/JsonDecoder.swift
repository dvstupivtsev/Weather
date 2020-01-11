//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Prelude
import Optics

class JsonDecoder<ObjectType: Decodable> {
    func parse(data: Data?) throws -> ObjectType {
        let decoder = JSONDecoder()
            |> \.dateDecodingStrategy .~ .secondsSince1970
        
        if let response = try data.flatMap({ try decoder.decode(ObjectType.self, from: $0) }) {
            return response
        } else {
            throw NSError.common
        }
    }
}
