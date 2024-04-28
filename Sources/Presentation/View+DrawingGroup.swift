import SwiftUI

public extension View {

    @ViewBuilder func drawingGroup(if condition: Bool) -> some View {
        if condition {
            drawingGroup()
        } else {
            self
        }
    }
}
