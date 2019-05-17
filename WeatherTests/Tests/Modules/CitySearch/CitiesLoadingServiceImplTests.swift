//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitiesLoadingServiceImplTests: XCTestCase {
    private var subject: CitiesLoadingServiceImpl!
    private var diskFileReader: DiskFileReaderMock!
    private var jsonDecoder: CitiesLoadingJsonDecoderMock!
    
    override func setUp() {
        super.setUp()
        
        diskFileReader = .init()
        jsonDecoder = .init()
        subject = CitiesLoadingServiceImpl(diskFileReader: diskFileReader, jsonDecoder: jsonDecoder)
    }

    func testGetCitiesSuccess() {
        diskFileReader.dataForReturnValue = Constants.data
        jsonDecoder.parseDataReturnValue = [.model1, .model2, .model3]
        
        var result = subject.getCities()
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(diskFileReader.dataForReceivedFileName, "cities")
        XCTAssertEqual(diskFileReader.dataForCallsCount, 1)
        
        XCTAssertEqual(jsonDecoder.parseDataReceivedData, diskFileReader.dataForReturnValue)
        XCTAssertEqual(jsonDecoder.parseDataCallsCount, 1)
        
        XCTAssertEqual(result.value, jsonDecoder.parseDataReturnValue)
        XCTAssertNil(result.error)
        
        result = subject.getCities()
        
        XCTAssertEqual(diskFileReader.dataForCallsCount, 1)
        XCTAssertEqual(jsonDecoder.parseDataCallsCount, 1)
        
        XCTAssertEqual(result.value, jsonDecoder.parseDataReturnValue)
        XCTAssertNil(result.error)
    }
    
    func testGetCitiesDiskFileReaderFailure() {
        let expectedError = Constants.error
        diskFileReader.dataForClosure = { _ in throw expectedError }
        
        let result = subject.getCities()
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(diskFileReader.dataForReceivedFileName, "cities")
        XCTAssertEqual(diskFileReader.dataForCallsCount, 1)
        XCTAssertEqual(jsonDecoder.parseDataCallsCount, 0)
        
        XCTAssertIdentical(result.error, to: expectedError)
        XCTAssertNil(result.value)
    }
    
    func testGetCitiesJsonDecoderFailure() {
        diskFileReader.dataForReturnValue = Constants.data
        
        let expectedError = Constants.error
        jsonDecoder.parseDataClosure = { _ in throw expectedError }
        
        let result = subject.getCities()
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(diskFileReader.dataForReceivedFileName, "cities")
        XCTAssertEqual(diskFileReader.dataForCallsCount, 1)
        
        XCTAssertEqual(jsonDecoder.parseDataReceivedData, diskFileReader.dataForReturnValue)
        XCTAssertEqual(jsonDecoder.parseDataCallsCount, 1)
        
        XCTAssertIdentical(result.error, to: expectedError)
        XCTAssertNil(result.value)
    }
}
