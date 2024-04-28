import SwiftUI

public extension View {

    @ViewBuilder func delayAppereance(after delay: Double) -> some View {
        modifier(DelayAppearanceModifier(delay: delay))
    }
}

private struct DelayAppearanceModifier: ViewModifier {

    private let delay: Double

    @State private var shouldAppear = false

    init(delay: Double) {
        self.delay = delay
    }

    func body(content: Content) -> some View {
        render(content)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.default) {
                        shouldAppear = true
                    }
                }
            }
    }

    @ViewBuilder private func render(_ content: Content) -> some View {
        if shouldAppear {
            content
        } else {
            content.hidden()
        }
    }
}
