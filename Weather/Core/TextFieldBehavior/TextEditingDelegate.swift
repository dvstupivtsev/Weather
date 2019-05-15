//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol TextEditingDelegate {
    func didChangeText(_ text: String?)
}
