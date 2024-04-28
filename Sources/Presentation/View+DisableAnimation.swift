import SwiftUI

public extension View {

    func disableAnimation() -> some View {
        transaction { $0.animation = nil }
    }
}
