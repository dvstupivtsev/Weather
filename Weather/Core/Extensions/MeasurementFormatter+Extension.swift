//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import Foundation

// sourcery: AutoMockable
protocol MeasurementFormatterProtocol {
    func string(from doubleCelsius: Double) -> String
}

extension MeasurementFormatter: MeasurementFormatterProtocol {
    static let celsius = make(MeasurementFormatter()) {
        $0.numberFormatter = .temperature
        $0.unitOptions = [.naturalScale, .temperatureWithoutUnit]
    }
    
    func string(from doubleCelsius: Double) -> String {
        return string(
            from: Measurement(value: doubleCelsius, unit: UnitTemperature.celsius)
        )
    }
}
