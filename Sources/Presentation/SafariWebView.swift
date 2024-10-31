import SafariServices
import SwiftUI

public struct SafariWebView: UIViewControllerRepresentable {

    private let url: URL

    @Environment(\.dismiss) private var dismiss

    public init(url: URL) {
        self.url = url
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> SFSafariViewController {
        let viewController = SFSafariViewController(url: url)
        viewController.delegate = context.coordinator
        return viewController
    }

    public func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: Context
    ) {
        context.coordinator.parent = self
    }

    @MainActor
    public class Coordinator: NSObject, SFSafariViewControllerDelegate {

        fileprivate var parent: SafariWebView

        public init(_ parent: SafariWebView) {
            self.parent = parent
            super.init()
        }

        nonisolated public func safariViewControllerDidFinish(
            _ controller: SFSafariViewController
        ) {
            Task {
                await parent.dismiss()
            }
        }
    }
}
