//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import UIKit

final class CitySearchTextFieldBehavior: NSObject, TextFieldBehavior {
    private let delegate: TextEditingDelegate
    
    init(delegate: TextEditingDelegate) {
        self.delegate = delegate
    }
    
    func setup(textField: UITextField) {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        delegate.didChangeText(textField.text)
    }
}
