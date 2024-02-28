import Foundation
import Kingfisher

final class KingFisherMock {
   enum Constants {
      static let cacheName = "KingFisherCache"
      static let imageURLString = "https://openweathermap.org/img/wn/10d@2x.png"
   }
   
   private var imageCache = ImageCache(name: Constants.cacheName)
   
   func mockImage() {
      KingfisherManager.shared.defaultOptions = [
         .onlyFromCache,
         .targetCache(imageCache)
      ]
      let options : [KingfisherOptionsInfoItem] = [.targetCache(imageCache)]
      imageCache.store(
         .clearSky,
         forKey:  Constants.imageURLString,
         options: KingfisherParsedOptionsInfo(KingfisherOptionsInfo(options))
      )
   }
   
   func clearCache() {
      imageCache.clearMemoryCache()
   }
}
