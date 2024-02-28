import Foundation
import UIKit

public extension UIAlertController {
   static func show(message: String,
                    title: String = "RandomWeather App",
                    action: UIAlertAction = .init(title: "Ok", style: .default),
                    on viewController: UIViewController) {
      let controller = UIAlertController.init(title: title ,
                                              message: message,
                                              preferredStyle: .alert)
      controller.addAction(action)
      
      viewController.present(controller, animated: true)
   }
}
