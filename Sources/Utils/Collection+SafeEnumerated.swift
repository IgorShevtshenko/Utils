public extension Collection {

    typealias EnumeratedElement = (Self.Index, Element)

    func safeEnumerated() -> [EnumeratedElement] {
        [EnumeratedElement](zip(indices, self))
    }
}
