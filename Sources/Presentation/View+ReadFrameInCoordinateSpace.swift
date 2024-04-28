import SwiftUI

public extension View {

    func readFrameIn(
        coordinateSpace: CoordinateSpace,
        onChange: @escaping (CGRect) -> Void
    ) -> some View {
        overlay(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: ViewFrameInCoordinateSpaceKey.self,
                        value: geometry.frame(in: coordinateSpace)
                    )
            }
        )
        .onPreferenceChange(ViewFrameInCoordinateSpaceKey.self) { newValue in
            DispatchQueue.main.async {
                onChange(newValue)
            }
        }
    }
}

private struct ViewFrameInCoordinateSpaceKey: PreferenceKey {

    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
