import SwiftUI

public extension Binding where Value: Sendable {

    init(from value: Value, onSet: @MainActor @escaping (Value) -> Void) {
        self = Binding(get: { value }, set: onSet)
    }
}

public extension Binding where Value: Equatable, Value: Sendable {

    func removeDuplicates() -> Self {
        Binding(
            get: { wrappedValue },
            set: { newValue, transaction in
                guard newValue != wrappedValue else { return }
                self.transaction(transaction).wrappedValue = newValue
            }
        )
    }
}
