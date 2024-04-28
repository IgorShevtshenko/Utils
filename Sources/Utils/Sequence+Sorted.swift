public enum Direction {
    case asc
    case desc
}

public extension Sequence {

    func sorted(
        by keyPath: KeyPath<Element, (some Comparable)?>,
        in direction: Direction
    ) -> [Element] {
        sorted { lhs, rhs in
            sortOptionalValues(
                lhs: lhs[keyPath: keyPath],
                rhs: rhs[keyPath: keyPath],
                by: direction
            )
        }
    }

    func sorted(
        by keyPath: KeyPath<Element, some Comparable>,
        in direction: Direction
    ) -> [Element] {
        sorted { lhs, rhs in
            direction.isIncreasing
                ? lhs[keyPath: keyPath] < rhs[keyPath : keyPath]:
                lhs[keyPath: keyPath] > rhs[keyPath: keyPath]
        }
    }

    private func sortOptionalValues<T: Comparable>(
        lhs: T?,
        rhs: T?,
        by direction: Direction
    ) -> Bool {
        switch (lhs != nil, rhs != nil) {
        case (false, false):
            return false
        case (true, false):
            return true
        case (false, true):
            return false
        case (true, true):
            guard let lhs, let rhs else { return false }
            return direction.isIncreasing
                ? lhs < rhs
                : lhs > rhs
        }
    }
}

private extension Direction {

    var isIncreasing: Bool {
        switch self {
        case .asc:
            true
        case .desc:
            false
        }
    }
}
