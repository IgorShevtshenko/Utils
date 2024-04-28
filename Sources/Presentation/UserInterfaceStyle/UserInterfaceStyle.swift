import SwiftUI
import UIKit

public enum UserInterfaceStyle: CaseIterable {
    case light
    case dark
    case unspecified
}

public extension View {

    @ViewBuilder func userInterfaceStyle(
        onReceiveNewStyle: @escaping (UIUserInterfaceStyle) -> Void
    ) -> some View {
        modifier(UserInterfaceStyleReceivingView(onReceiveNewStyle: onReceiveNewStyle))
    }
}

public class UserInterfaceStyleEnvironment: ObservableObject {

    private let updateUserInterfaceStyle: (UIUserInterfaceStyle) -> Void

    fileprivate init(updateUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Void) {
        self.updateUserInterfaceStyle = updateUserInterfaceStyle
    }

    public func callAsFunction(updateStyle userInterfaceStyle: UserInterfaceStyle) {
        updateUserInterfaceStyle(userInterfaceStyle.toUserInterfaceStyle())
    }
}

private struct UserInterfaceStyleReceivingView: ViewModifier {

    private let onReceiveNewStyle: (UIUserInterfaceStyle) -> Void

    public init(onReceiveNewStyle: @escaping (UIUserInterfaceStyle) -> Void) {
        self.onReceiveNewStyle = onReceiveNewStyle
    }

    public func body(content: Content) -> some View {
        content.environmentObject(
            UserInterfaceStyleEnvironment(updateUserInterfaceStyle: onReceiveNewStyle)
        )
    }
}

private extension UserInterfaceStyle {

    func toUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .light:
            .light
        case .dark:
            .dark
        case .unspecified:
            .unspecified
        }
    }
}
