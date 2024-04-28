import SwiftUI
import UIKit

public class ZoomableScrollCoordinator<Content: View>: NSObject, UIScrollViewDelegate {

    let scrollView = UIScrollView()
    let hostingController: UIHostingController<Content>

    private var isCalculatedZoom = false

    init(content: Content) {
        hostingController = UIHostingController(rootView: content)
    }

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        hostingController.view
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveContentToCenter()
    }

    func centerOfContent(to zoom: CGFloat, tapped point: CGPoint) -> CGRect {
        if let view = viewForZooming(in: scrollView) {
            let newCenter = view.convert(point, from: scrollView)
            let newHeight = view.frame.size.height/zoom
            let newWidth = view.frame.size.width/zoom
            return CGRect(
                x: newCenter.x - (newWidth/2.0),
                y: newCenter.y - (newHeight/2.0),
                width: newWidth,
                height: newHeight
            )
        }
        return CGRect.zero
    }

    func calculateZoomIfNeeded() {
        guard !isCalculatedZoom else {
            return
        }
        isCalculatedZoom = true
        calculateZoomScale()
        moveContentToCenter()
    }

    private func calculateZoomScale() {
        guard let contentView = hostingController.view else {
            return
        }
        let minScaleByWidth = scrollView.frame.size.width/contentView.frame.size.width
        let minScaleByHeight = scrollView.frame.size.height/contentView.frame.size.height
        let minScale = min(minScaleByWidth, minScaleByHeight)
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = minScale * 3
        scrollView.setZoomScale(minScale, animated: false)
    }

    private func moveContentToCenter() {
        let safeAreaInsets = scrollView.safeAreaInsets
        let scrollViewBoundsSize = scrollView.bounds.size
        let scrollViewHeight = scrollViewBoundsSize.height -
            safeAreaInsets.top - safeAreaInsets.bottom
        let scrollViewWidth = scrollViewBoundsSize.width -
            safeAreaInsets.left - safeAreaInsets.right

        let offsetX = max((scrollViewWidth - scrollView.contentSize.width) * 0.5, 0.0)
        let offsetY = max((scrollViewHeight - scrollView.contentSize.height) * 0.5, 0.0)

        scrollView.contentInset = UIEdgeInsets(
            top: offsetY,
            left: offsetX,
            bottom: offsetY,
            right: offsetX
        )
    }
}
