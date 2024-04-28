import SwiftUI

public extension View {
    func asAny() -> AnyView { AnyView(self) }
}
