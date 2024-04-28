import SwiftUI

public extension View {
    
    @ViewBuilder func ignoreSafeAreaBackground(_ background: some View) -> some View {
        ZStack {
            background
                .ignoresSafeArea()
            self
        }
    }
}
