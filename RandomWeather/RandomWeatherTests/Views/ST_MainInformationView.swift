import SnapshotTesting
import XCTest
@testable import RandomWeather

class ST_MainInformationView: XCTestCase {
   
   private var sut: MainInformationView!
   
   override func setUp() {
      super.setUp()
      sut = MainInformationView(frame: .init(x: 0, y: 0, width: 320, height: 250))
   }
   
   func test_view() {
      let viewModel = givenViewModel()
      sut.apply(viewModel: viewModel)
      assertSnapshot(matching: sut, as: .image)
   }
   
   override func tearDown() {
      sut = nil
      super.tearDown()
   }
   
   private func givenViewModel() -> MainInformationViewModel {
      .init(location: "Barcelona, ES",
            latitude: "Lat: 41.3874",
            longitude: "Lon: 2.1686",
            temperature: "11°C",
            description: "Mostly Cloudy",
            minTemperature: "L: 9°C",
            maxTemperature: "H: 9°C")
   }
}
