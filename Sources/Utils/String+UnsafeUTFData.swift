import Foundation

public enum DataEncodingError: Error {
    case errorOnStringEncoding
    case errorOnDataEncoding
}

public extension String {

    func unsafeUTF8Data() throws -> Data {
        guard let data = data(using: .utf8) else {
            throw DataEncodingError.errorOnStringEncoding
        }
        return data
    }
}

public extension Data {

    func unsafeStringWithUTF8() throws -> String {
        guard let result = String(data: self, encoding: .utf8) else {
            throw DataEncodingError.errorOnDataEncoding
        }
        return result
    }
}
