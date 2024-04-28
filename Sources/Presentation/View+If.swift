import SwiftUI

public extension View {

    @ViewBuilder func `if`(
        _ conditional: Bool,
        _ content: (Self) -> some View
    ) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}
