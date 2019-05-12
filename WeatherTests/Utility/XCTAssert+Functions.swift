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
            XCTFail(message(), file: file, line: line)
            return
        }
        
        let receivedObjectTypeString = String(describing: type(of: object))
        let expectedTypeString = String(describing: expectedClass)
        XCTAssertEqual(receivedObjectTypeString, expectedTypeString, message(), file: file, line: line)
    } catch {
        XCTFail(message(), file: file, line: line)
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
            XCTFail("Received collection is nil", file: file, line: line)
            return
        }
        
        XCTAssertTrue(collection.isEmpty, file: file, line: line)
    } catch {
        XCTFail(message(), file: file, line: line)
    }
}

func XCTAssertNotEmpty<Type: Collection>(
    _ expression: @autoclosure () throws -> Type?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    do {
        guard let collection = try expression() else {
            XCTFail("Received collection is nil", file: file, line: line)
            return
        }
        
        XCTAssertTrue(collection.isEmpty == false, file: file, line: line)
    } catch {
        XCTFail(message(), file: file, line: line)
    }
}
