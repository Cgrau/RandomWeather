import Foundation

extension Double {
   func toCelcius() -> Double {
      return (self / 33.8).rounded(to: 1)
   }
}
