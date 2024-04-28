import SwiftUI

public extension EdgeInsets {

    init(_ uiEdgeInsets: UIEdgeInsets) {
        self = EdgeInsets(
            top: uiEdgeInsets.top,
            leading: uiEdgeInsets.left,
            bottom: uiEdgeInsets.bottom,
            trailing: uiEdgeInsets.right
        )
    }
}
