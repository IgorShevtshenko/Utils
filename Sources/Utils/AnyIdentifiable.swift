import Foundation

public struct AnyIdentifiable<T: Hashable>: Identifiable, Equatable {

    public let id: Int
    public let value: T

    public init(_ value: T) {
        self.value = value
        id = value.hashValue
    }
}

public extension Hashable {

    func asIdentifiable() -> AnyIdentifiable<Self> {
        AnyIdentifiable(self)
    }
}
