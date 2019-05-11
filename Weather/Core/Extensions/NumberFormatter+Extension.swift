//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol NumberFormatterProtocol {
    func string(from value: Double) -> String
}

extension NumberFormatter: NumberFormatterProtocol {
    func string(from value: Double) -> String {
        return string(from: NSNumber(value: value)) ?? ""
    }
}

extension NumberFormatter {
    static let temperature = make(NumberFormatter()) {
        $0.minimumIntegerDigits = 1
        $0.minimumFractionDigits = 0
        $0.maximumFractionDigits = 0
        $0.numberStyle = .decimal
        $0.generatesDecimalNumbers = true
    }
}
