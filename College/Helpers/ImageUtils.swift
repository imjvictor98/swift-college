import Foundation
import UIKit

class ImageUtils {
    static func roundImage(roundFor image: UIImageView) -> Void {
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        image.layer.cornerRadius = 62.225
        image.clipsToBounds = true
    }
}
