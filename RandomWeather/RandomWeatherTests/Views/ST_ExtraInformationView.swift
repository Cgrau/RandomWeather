import SnapshotTesting
import XCTest
@testable import RandomWeather

class ST_ExtraInformationView: XCTestCase {
   enum Constants {
      static let title = "Extra Information:"
      static let pressure = "Pressure: 1009 hPa"
      static let humidity = "Humidity: 97%"
      static let seaLevel = "Pressure at sea level: 1009 hPa"
      static let groundLevel = "Pressure at ground level: 1009 hPa"
   }
   
   private var sut: ExtraInformationView!
   
   override func setUp() {
      super.setUp()
      sut = ExtraInformationView(frame: .init(x: 0, y: 0, width: 320, height: 200))
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
   
   private func givenViewModel() -> ExtraInformationViewModel {
      .init(title: Constants.title,
            pressure: Constants.pressure,
            humidity: Constants.humidity,
            seaLevel: Constants.seaLevel,
            groundLevel: Constants.groundLevel)
   }
}
