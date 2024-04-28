import SwiftUI

public extension Binding {

    init(from value: Value, onSet: @escaping (Value) -> Void) {
        self = Binding(get: { value }, set: onSet)
    }
}

public extension Binding where Value: Equatable {

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
