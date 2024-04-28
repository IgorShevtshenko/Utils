import SwiftUI

public struct ZoomableScrollView<Content: View>: UIViewControllerRepresentable {

    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        ZoomableScrollViewController(coordinator: context.coordinator)
    }

    public func makeCoordinator() -> ZoomableScrollCoordinator<Content> {
        ZoomableScrollCoordinator(content: content)
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        context.coordinator.hostingController.rootView = content
    }
}
