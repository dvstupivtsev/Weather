//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import XCTest

func XCTAssert(
    _ expression: @autoclosure () throws -> Any?,
    isKindOf expectedClass: AnyClass,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    do {
        guard let object = try expression() else {
            let message = createMessage(with: "Expected object is kind of \(expectedClass), received nil", message())
            XCTFail(message, file: file, line: line)
            return
        }
        
        let receivedObjectTypeString = String(describing: type(of: object))
        let expectedTypeString = String(describing: expectedClass)
        XCTAssertEqual(receivedObjectTypeString, expectedTypeString, message(), file: file, line: line)
    } catch {
        XCTFail(error.localizedDescription, file: file, line: line)
    }
}

func XCTAssertEmpty<Type: Collection>(
    _ expression: @autoclosure () throws -> Type?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    do {
        guard let collection = try expression() else {
            XCTFail(createMessage(with: "Received collection is nil", message()), file: file, line: line)
            return
        }
        
        if collection.isEmpty == false {
            let message = createMessage(with: "expected \(collection) is empty, received with \(collection.count) elements", message())
            XCTFail(message, file: file, line: line)
        }
    } catch {
        XCTFail(error.localizedDescription, file: file, line: line)
    }
}

private func createMessage(with messages: String...) -> String {
    return messages
        .filter { $0.isEmpty == false }
        .joined(separator: " - ")
}

func XCTAssertNotEmpty<Type: Collection>(
    _ expression: @autoclosure () throws -> Type?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    do {
        guard let collection = try expression() else {
            XCTFail(createMessage(with: "Received collection is nil", message()), file: file, line: line)
            return
        }
        
        if collection.isEmpty {
            let message = createMessage(with: "expected \(collection) is not empty, received empty", message())
            XCTFail(message, file: file, line: line)
        }
    } catch {
        XCTFail(error.localizedDescription, file: file, line: line)
    }
}

func XCTAssertIdentical(
    _ expression: @autoclosure () throws -> Any?,
    to expected: Any,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    do {
        guard let received = try expression() else {
            XCTFail(createMessage(with: "expected to \(expected), received nil", message()), file: file, line: line)
            return
        }
        
        if received as AnyObject !== expected as AnyObject {
            let message = createMessage(with: "\(received) is not identical to \(expected)", message())
            XCTFail(message, file: file, line: line)
        }
    } catch {
        XCTFail(error.localizedDescription, file: file, line: line)
    }
}
