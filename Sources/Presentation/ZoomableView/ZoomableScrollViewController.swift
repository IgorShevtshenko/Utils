import SwiftUI
import UIKit

class ZoomableScrollViewController<Content: View>: UIViewController {

    private let coordinator: ZoomableScrollCoordinator<Content>

    private var scrollView: UIScrollView {
        coordinator.scrollView
    }

    private var contentView: UIView {
        guard let view = coordinator.hostingController.view else {
            fatalError("Cannot get view from hosting controller at coordinator")
        }
        return view
    }

    init(coordinator: ZoomableScrollCoordinator<Content>) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        coordinator.calculateZoomIfNeeded()
    }

    public override func loadView() {
        view = scrollView
    }

    private func setup() {
        contentView.backgroundColor = nil
        scrollView.delegate = coordinator
        scrollView.backgroundColor = nil
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }

    @objc private func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            let center = coordinator.centerOfContent(
                to: scrollView.minimumZoomScale/0.5,
                tapped: recognizer.location(in: recognizer.view)
            )
            scrollView.zoom(to: center, animated: true)
        }
    }

    private func layout() {
        scrollView.addSubview(contentView)
        contentView.constrain(edges: .all, to: scrollView)
    }
}
