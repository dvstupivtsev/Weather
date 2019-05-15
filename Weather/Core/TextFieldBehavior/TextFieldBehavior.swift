//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import UIKit

protocol TextFieldBehavior: AnyObject, UITextFieldDelegate {
    func setup(textField: UITextField)
}
