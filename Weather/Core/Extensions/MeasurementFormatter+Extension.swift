//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import Foundation

extension MeasurementFormatter {
    static let celsius = make(object: MeasurementFormatter()) {
        $0.numberFormatter = make(object: NumberFormatter()) {
            $0.minimumIntegerDigits = 1
            $0.minimumFractionDigits = 0
            $0.maximumFractionDigits = 0
            $0.numberStyle = .decimal
            $0.generatesDecimalNumbers = true
        }
        
        $0.unitOptions = [.naturalScale, .temperatureWithoutUnit]
    }
    
    func string(from double: Double) -> String {
        return string(
            from: Measurement(value: double, unit: UnitTemperature.celsius)
        )
    }
}
