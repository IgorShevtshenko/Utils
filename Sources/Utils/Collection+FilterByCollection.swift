public extension Collection where Element: Equatable {

    func filter(by collection: Self) -> [Self.Element] {
        filter { element in
            collection.contains(where: { $0 == element })
        }
    }
}
