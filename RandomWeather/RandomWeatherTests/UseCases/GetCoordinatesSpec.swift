import XCTest
import Combine
@testable import RandomWeather

class GetCoordinatesSpec: XCTestCase {
   
   func testExecuteReturnsValidCoordinates() {
      // Given
      let getCoordinates = GetCoordinates.buildDefault()
      
      // When
      let coordinates = getCoordinates.execute()
      
      // Then
      XCTAssertNotNil(coordinates)
      XCTAssertTrue(-90...90 ~= coordinates.latitude)
      XCTAssertTrue(-180...180 ~= coordinates.longitude)
   }
   
   func testExecuteProducesDifferentCoordinates() {
      // Given
      let getCoordinates = GetCoordinates.buildDefault()
      
      // When
      let coordinates1 = getCoordinates.execute()
      let coordinates2 = getCoordinates.execute()
      
      // Then
      XCTAssertNotEqual(coordinates1.latitude, coordinates2.latitude)
      XCTAssertNotEqual(coordinates1.longitude, coordinates2.longitude)
   }
   
   func testBuildDefaultReturnsInstance() {
      // When
      let getCoordinates = GetCoordinates.buildDefault()
      
      // Then
      XCTAssertNotNil(getCoordinates)
   }
}
