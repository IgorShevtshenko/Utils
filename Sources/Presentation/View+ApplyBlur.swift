import SwiftUI

public extension View {

    func applyBlackout(when isBlurred: Bool) -> some View {
        ZStack {
            self
            Color.black.opacity(isBlurred ? 0.35 : 0)
                .ignoresSafeArea(.all)
                .animation(.easeOut(duration: 0.2), value: isBlurred)
        }
    }
}
