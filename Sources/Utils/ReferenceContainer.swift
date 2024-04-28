import Combine
import Foundation

public final class ReferenceContainer {

    private var cancellables = Set<AnyCancellable>()

    public init(publisher: some Publisher, timeoutInSeconds: Int = 15) {
        publisher
            .timeout(
                .seconds(timeoutInSeconds),
                scheduler: DispatchQueue.main
            )
            .handleEvents(receiveCompletion: { _ in
                self.release()
            })
            .sink()
            .store(in: &cancellables)
    }

    public func release() {
        cancellables = []
    }
}
