import SwiftUI
import UIKit

public extension View {

    func userInterfaceStyle(item: Binding<UserInterfaceStyle>) -> some View {
        modifier(UserInterfaceStyleModifier(item: item))
    }
}

private struct UserInterfaceStyleModifier: ViewModifier {

    @EnvironmentObject var userInterfaceStyle: UserInterfaceStyleEnvironment

    @Binding private var item: UserInterfaceStyle

    init(item: Binding<UserInterfaceStyle>) {
        _item = item
    }

    @ViewBuilder public func body(content: Content) -> some View {
        content.onChange(of: item, initial: true) { _, newValue in
            userInterfaceStyle(updateStyle: newValue)
        }
    }
}
