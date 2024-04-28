import SwiftUI
import UIKit

public extension View {

    func onView(
        willAppear: @escaping () -> Void = {},
        didAppear: @escaping () -> Void = {},
        didDisappear: @escaping () -> Void = {}
    ) -> some View {
        background(
            HelperView(
                willAppear: willAppear,
                didAppear: didAppear,
                didDisappear: didDisappear
            )
        )
    }
}

private struct HelperView: UIViewControllerRepresentable {

    private let willAppear: () -> Void
    private let didAppear: () -> Void
    private let didDisappear: () -> Void

    init(
        willAppear: @escaping () -> Void = {},
        didAppear: @escaping () -> Void = {},
        didDisappear: @escaping () -> Void = {}
    ) {
        self.willAppear = willAppear
        self.didAppear = didAppear
        self.didDisappear = didDisappear
    }

    func makeUIViewController(context _: Context) -> HelperViewController {
        HelperViewController(
            willAppear: willAppear,
            didAppear: didAppear,
            didDisappear: didDisappear
        )
    }

    func updateUIViewController(_: HelperViewController, context _: Context) {}
}

private class HelperViewController: UIViewController {

    private let willAppear: () -> Void
    private let didAppear: () -> Void
    private let didDisappear: () -> Void

    init(
        willAppear: @escaping () -> Void,
        didAppear: @escaping () -> Void,
        didDisappear: @escaping () -> Void
    ) {
        self.willAppear = willAppear
        self.didAppear = didAppear
        self.didDisappear = didDisappear
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear()
    }
}
