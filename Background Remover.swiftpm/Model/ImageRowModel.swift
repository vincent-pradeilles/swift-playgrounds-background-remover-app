import Foundation
import UIKit
import CoreLocation

enum ImageRowModelResult {
    case progress(Double)
    case result(UIImage)
    case error
}

struct ImageRowModel {
    let original: UIImage
    var result: ImageRowModelResult = .progress(0)
}

extension ImageRowModel: Identifiable {
    var id: Int {
        original.hash
    }
}
