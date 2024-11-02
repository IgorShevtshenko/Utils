import Combine

public extension Future {
    
    @MainActor
    static func run<O: Sendable, F: Error>(
        asyncFunc: @escaping () async throws(F) -> O
    ) -> Future<O, F> {
        Future<O, F> { promise in
            Task {
                do {
                    let result = try await asyncFunc()
                    promise(.success(result))
                } catch {
                    guard let error = error as? F else {
                        fatalError("Invalid Error type")
                    }
                    promise(.failure(error))
                }
            }
        }
    }
}
