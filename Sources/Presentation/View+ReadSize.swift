import SwiftUI

public extension View {

    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        overlay(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: ViewSizeKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(ViewSizeKey.self) { newValue in
            DispatchQueue.main.async {
                onChange(newValue)
            }
        }
    }
}

private struct ViewSizeKey: PreferenceKey {

    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
