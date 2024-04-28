import Foundation

public struct LossyDecodingArray<Element: Decodable> {
    public let elements: [Element]
    public let errors: [Error]

    public init(elements: [Element], errors: [Error] = []) {
        self.elements = elements
        self.errors = errors
    }
}

public extension JSONDecoder {

    func lossyDecode<T>(
        _ type: T.Type,
        from data: Data
    ) throws -> LossyDecodingArray<T.Element> where T: Collection, T.Element: Decodable {
        try decode(LossyDecodingArray<T.Element>.self, from: data)
    }

    func lossyDecodeValues<T>(
        _ type: T.Type,
        from data: Data
    ) throws -> [T.Element] where T: Collection, T.Element: Decodable {
        try lossyDecode(type, from: data).elements
    }
}

extension LossyDecodingArray: Decodable where Element: Decodable {

    private struct ElementWrapper: Decodable {
        var element: Element?
        var error: Error?

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                element = try container.decode(Element.self)
            } catch {
                self.error = error
            }
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let result = try container.decode([ElementWrapper].self)
        elements = result.compactMap(\.element)
        errors = result.compactMap(\.error)
    }
}
