import Foundation
import SwiftUI

public struct DynamicPadding: View {

    private let minLength: CGFloat
    private let maxLength: CGFloat

    public init(
        minLength: CGFloat,
        maxLength: CGFloat
    ) {
        self.minLength = minLength
        self.maxLength = maxLength
    }

    public var body: some View {
        Spacer(minLength: minLength)
            .frame(maxWidth: maxLength, maxHeight: maxLength)
    }
}
