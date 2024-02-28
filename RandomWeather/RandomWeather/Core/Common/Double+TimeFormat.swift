import Foundation

extension Double {
   func toTimeFormat(timeZoneOffsetInSeconds: Int = 0) -> String {
      let date = Date(timeIntervalSince1970: self)
      let formatter = DateFormatter()
      formatter.timeZone = TimeZone(secondsFromGMT: timeZoneOffsetInSeconds)
      formatter.dateFormat = "HH:mm"
      let time = formatter.string(from: date)
      return time
   }
}
