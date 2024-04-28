public enum Cursor: Hashable, Equatable {
    case end
    case page(Int)
}

public struct PaginatedArray<Element: Hashable>: Equatable {

    public let elements: [Element]
    public let cursor: Cursor
    public let totalElements: Int

    public init(elements: [Element], cursor: Cursor, totalElements: Int) {
        self.elements = elements
        self.cursor = cursor
        self.totalElements = totalElements
    }
}
