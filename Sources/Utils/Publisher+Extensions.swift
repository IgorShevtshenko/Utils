import Combine

public extension Publisher where Output == Never {

    func setOutputType<NewOutput>(
        to outputType: NewOutput.Type
    ) -> Publishers.Map<Self, NewOutput> {
        map { _ -> NewOutput in }
    }
    
    func then<T, P: Publisher>(
        _ publisher: P
    ) -> AnyPublisher<T, Failure> where P.Output == T, P.Failure == Failure {
        andThen(justReturn: ())
            .flatMap { _ in publisher }
            .eraseToAnyPublisher()
    }

    func andThen<T, P: Publisher>(
        _ publisher: P
    ) -> AnyPublisher<T, Failure> where P.Output == T, P.Failure == Failure {
        setOutputType(to: T.self)
            .compactMap { $0 }
            .append(publisher)
            .eraseToAnyPublisher()
    }

    func andThen<T, P: Publisher>(
        _ publisher: P
    ) -> AnyPublisher<T, Failure> where P.Output == T, P.Failure == Never {
        andThen(publisher.setFailureType(to: Failure.self))
    }

    func andThen<Element>(justReturn output: Element) -> AnyPublisher<Element, Failure> {
        andThen(Just(output))
    }

    func replaceError<T>(_ transform: @escaping (Failure) -> T) -> AnyPublisher<T, Never> {
        setOutputType(to: T.self)
            .catch { Just(transform($0)) }
            .eraseToAnyPublisher()
    }
}

public extension Publisher {

    func ignoreFailure() -> AnyPublisher<Output, Never> {
        self.catch { _ in Empty<Output, Never>() }.eraseToAnyPublisher()
    }

    func removeDuplicates(
        by keyPath: KeyPath<Output?, some Equatable>
    ) -> Publishers.RemoveDuplicates<Self> {
        removeDuplicates { $0[keyPath: keyPath] == $1[keyPath: keyPath] }
    }

    func throwError(
        _ error: Failure,
        when predicate: @escaping (Output) -> Bool
    ) -> AnyPublisher<Output, Failure> {
        tryMap { output in
            if predicate(output) {
                throw error
            }
            return output
        }
        .mapError { error in
            guard let error = error as? Failure else {
                fatalError("Can't cast error in required type. Received error: \(error)")
            }
            return error
        }
        .eraseToAnyPublisher()
    }

    func removeOptionals<T>() -> AnyPublisher<[T], Failure> where Output == [T?] {
        map { $0.compactMap { $0 } }.eraseToAnyPublisher()
    }
}
