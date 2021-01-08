

import Foundation
import Cocoa

extension NSSize {
    init(quadratic width: CGFloat) {
        self.init(width: width, height: width)
    }
}
