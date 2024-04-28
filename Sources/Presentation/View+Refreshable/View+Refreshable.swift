import SwiftUI

public extension View {

    @ViewBuilder func refreshable(isRefreshing: Binding<Bool>) -> some View {
        modifier(RefreshableModifier(isRefreshing: isRefreshing))
    }
}

private struct RefreshableModifier: ViewModifier {

    @Binding private var isRefreshing: Bool

    @StateObject private var pullToRefreshCoordinator: PullToRefreshCoordinator

    public init(isRefreshing: Binding<Bool>) {
        _isRefreshing = isRefreshing
        _pullToRefreshCoordinator = StateObject(
            wrappedValue: PullToRefreshCoordinator(isRefreshing: isRefreshing)
        )
    }

    public func body(content: Content) -> some View {
        content
            .refreshable {
                await pullToRefreshCoordinator.startRefreshing()
            }
            .onChange(of: isRefreshing) { _, isRefreshing in
                pullToRefreshCoordinator.updateIsPullingToRefresh(isRefreshing)
            }
    }
}
