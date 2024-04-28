import CryptoKit
import Foundation

public protocol NonceGenerator {
    func randomNonceString() -> String
    func encryptNonceWithSHA256(_ input: String) -> String
}

public struct NonceGeneratorImpl: NonceGenerator {
    
    public init() {}
    
    public func randomNonceString() -> String {
        var randomBytes = [UInt8](repeating: 0, count: 32)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    public func encryptNonceWithSHA256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}
