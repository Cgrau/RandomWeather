import SnapshotTesting
import XCTest
@testable import RandomWeather

class ST_WindInformationView: XCTestCase {
   
   private var sut: WindInformationView!
   
   override func setUp() {
      super.setUp()
      sut = WindInformationView(frame: .init(x: 0, y: 0, width: 320, height: 90))
   }
   
   func test_view() {
      let viewModel = givenViewModel(directionImage: getWindDirectionImage())
      sut.apply(viewModel: viewModel)
      assertSnapshot(matching: sut, as: .image)
   }
   
   func test_view_no_wind_direction() {
      let viewModel = givenViewModel()
      sut.apply(viewModel: viewModel)
      assertSnapshot(matching: sut, as: .image)
   }
   
   override func tearDown() {
      sut = nil
      super.tearDown()
   }
   
   private func givenViewModel(directionImage: UIImage? = nil) -> WindInformationViewModel {
      .init(title: "Wind Information:",
            speed: "Speed: 2.24",
            gust: "Gust: 1.62",
            directionImage: directionImage)
   }
   
   private func getWindDirectionImage() -> UIImage? {
      .upArrow.rotated(byDegrees: 45)
   }
}
