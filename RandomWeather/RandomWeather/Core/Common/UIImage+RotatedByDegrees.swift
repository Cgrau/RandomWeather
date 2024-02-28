import UIKit

extension UIImage {
    func rotated(byDegrees degrees: CGFloat) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }

        let radians = degrees * .pi / 180.0

        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
            .integral.size

        UIGraphicsBeginImageContext(rotatedSize)
        defer { UIGraphicsEndImageContext() }

        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
            context.rotate(by: radians)
            draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
            
            if let rotatedImage = UIGraphicsGetImageFromCurrentImageContext() {
                return rotatedImage
            }
        }

        return nil
    }
}
