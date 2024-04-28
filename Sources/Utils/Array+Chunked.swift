import Foundation

public extension Array {

    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map { step in
            Array(self[step..<Swift.min(step + size, count)])
        }
    }
}
