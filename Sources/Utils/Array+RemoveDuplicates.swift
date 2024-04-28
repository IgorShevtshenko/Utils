import Foundation

public extension Array {

    func removingDuplicates<T: Hashable>(byKey key: (Element) -> T) -> [Element] {
        var result = [Element]()
        var seen = Set<T>()
        for value in self where seen.insert(key(value)).inserted {
            result.append(value)
        }
        return result
    }
}
