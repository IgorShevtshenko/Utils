import SwiftUI

public struct ScrollViewSafeAreaFixingModifier: ViewModifier {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .padding(.vertical, 1)
    }
}
