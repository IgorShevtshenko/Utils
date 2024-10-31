import Combine

public extension Publisher where Output: Sendable {
    
    func async() async throws(Failure) -> Output {
        var cancellable: AnyCancellable?
        defer { cancellable?.cancel() }
        do {
            return try await withCheckedThrowingContinuation { continuation in
                cancellable = sink { result in
                        switch result {
                        case .finished:
                            break
                        case let .failure(error):
                            continuation.resume(throwing: error)
                        }
                    } receiveValue: { value in
                        continuation.resume(with: .success(value))
                    }
            }
        } catch {
            guard let error = error as? Failure else {
                fatalError("Invalid Error type")
            }
            throw error
        }
    }
}
