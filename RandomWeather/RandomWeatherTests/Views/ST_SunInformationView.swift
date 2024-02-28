import SnapshotTesting
import XCTest
@testable import RandomWeather

class ST_SunInformationView: XCTestCase {
   enum Constants {
      static let title = "Sunrise and sunset times:"
      static let sunrise = "Sunrise: 7:03"
      static let sunset = "Sunrise: 9:02"
   }
   
   private var sut: SunInformationView!
   
   override func setUp() {
      super.setUp()
      sut = SunInformationView(frame: .init(x: 0, y: 0, width: 320, height: 100))
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
   
   private func givenViewModel() -> SunInformationViewModel {
      .init(title: Constants.title,
            sunrise: Constants.sunrise,
            sunset: Constants.sunset,
            icon: .sun)
   }
}
