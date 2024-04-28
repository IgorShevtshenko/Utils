import Combine

public extension AnyPublisher {

    func sink() -> AnyCancellable where Failure == Never {
        sink { _ in }
    }

    func sink(
        receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void
    ) -> AnyCancellable {
        sink(receiveCompletion: receiveCompletion, receiveValue: { _ in })
    }
}

public extension Publisher {

    func sink(
        receiveValue: @escaping (Self.Output) -> Void = { _ in },
        receiveSuccess: @escaping () -> Void = {},
        receiveFailure: @escaping (Failure) -> Void = { _ in }
    ) -> AnyCancellable {
        sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    receiveSuccess()
                case .failure(let error):
                    receiveFailure(error)
                }
            },
            receiveValue: { receiveValue($0) }
        )
    }
}
