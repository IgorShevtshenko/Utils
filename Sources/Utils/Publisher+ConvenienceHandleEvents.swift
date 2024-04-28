import Combine

public extension Publisher {

    func handleEvents(
        receiveSubscription: ((Subscription) -> Void)? = nil,
        receiveOutput: ((Self.Output) -> Void)? = nil,
        receiveCancel: (() -> Void)? = nil,
        receiveRequest: ((Subscribers.Demand) -> Void)? = nil,
        receiveSuccess: (() -> Void)? = nil,
        receiveFailure: ((Self.Failure) -> Void)? = nil
    ) -> Publishers.HandleEvents<Self> {
        handleEvents(
            receiveSubscription: receiveSubscription,
            receiveOutput: receiveOutput,
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    receiveSuccess?()
                case .failure(let error):
                    receiveFailure?(error)
                }
            },
            receiveCancel: receiveCancel,
            receiveRequest: receiveRequest
        )
    }
}
