import SwiftUI

public extension View {

    func isHidden(_ conditional: Bool) -> some View {
        modifier(HiddenModifier(isHidden: conditional))
    }
}

private struct HiddenModifier: ViewModifier {

    private let isHidden: Bool

    init(isHidden: Bool) {
        self.isHidden = isHidden
    }

    @ViewBuilder func body(content: Content) -> some View {
        if isHidden {
            EmptyView()
        } else {
            content
        }
    }
}
