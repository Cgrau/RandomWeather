import Foundation

extension Double {
   func toTimeFormat() -> String {
      let date = Date(timeIntervalSince1970: self)
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      let time = formatter.string(from: date)
      return time
   }
}
