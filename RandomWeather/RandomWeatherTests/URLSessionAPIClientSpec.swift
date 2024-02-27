import XCTest
import Combine
@testable import RandomWeather

class URLSessionAPIClientSpec: XCTestCase {
   let mockJSONFileName = "get.weather.success1"
   
   func testWeatherEndpointWithMockJSON() {
      // Given
      let jsonData = loadMockJSONData()
      let endpoint = WeatherEndpoint.getWeather(request: .init(latitude: 1, longitude: 1))
      let response = HTTPURLResponse(url: endpoint.baseURL, statusCode: 200, httpVersion: nil, headerFields: endpoint.headers)!
      let mockSession = MockURLSession(data: jsonData, response: response)
      let apiClient = URLSessionAPIClient<WeatherEndpoint>.init(session: mockSession)
      
      // When
      let expectation = XCTestExpectation(description: "Wait for the response")
      
      _ = apiClient.request(endpoint)
         .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
               break // Success
            case .failure(let error):
               XCTFail("Unexpected error: \(error)")
            }
            expectation.fulfill()
         }, receiveValue: { (result: WeatherDataModel) in
            XCTAssertEqual(result.name, "")
         })
      
      wait(for: [expectation], timeout: 5.0)
   }

   private func loadMockJSONData() -> Data {
      let bundle = Bundle(for: type(of: self))
      guard let url = bundle.url(forResource: mockJSONFileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
         fatalError("Unable to load JSON file.")
      }
      return data
   }
}
