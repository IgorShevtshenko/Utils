public extension Array {

    func split(into size: Int) -> [[Element]] {
        (0..<size).map { index in
            stride(from: index, to: count, by: size).map { self[$0] }
        }
    }
}
