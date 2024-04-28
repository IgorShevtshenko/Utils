import SwiftUI

final class PullToRefreshCoordinator: ObservableObject {

    @Published private var isPullingToRefresh = false
    @Binding private var isRefreshing: Bool

    init(isRefreshing: Binding<Bool>) {
        _isRefreshing = isRefreshing
    }

    @MainActor
    func startRefreshing() async {
        isRefreshing = true
        isPullingToRefresh = true
        while isPullingToRefresh {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
        }
    }

    func updateIsPullingToRefresh(_ isPullingToRefresh: Bool) {
        self.isPullingToRefresh = isPullingToRefresh
    }
}
