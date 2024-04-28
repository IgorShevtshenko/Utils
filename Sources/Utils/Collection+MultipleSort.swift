import Foundation

public extension Collection {

    typealias Predicate = (Element, Element) -> Bool

    func multipleSort(by predicates: @escaping () -> [Predicate]) -> [Element] {
        sorted { lhs, rhs in
            for predicate in predicates() {
                if !predicate(lhs, rhs), !predicate(rhs, lhs) {
                    continue
                }
                return predicate(lhs, rhs)
            }
            return false
        }
    }
}
