public extension Array {

    func append(
        _ collection: Self,
        if predicate: Bool
    ) -> Self {
        if predicate { return self + collection }
        return self
    }
    
    func remove(
        _ collection: Self,
        if predicate: Bool
    ) -> Self where Element: Hashable {
        if predicate { return Array(Set(self).subtracting(collection)) }
        return self
    }
}
