public extension Array {

    func append(
        _ collection: Self,
        if predicate: Bool
    ) -> Self {
        if predicate { return self + collection }
        return self
    }
}
