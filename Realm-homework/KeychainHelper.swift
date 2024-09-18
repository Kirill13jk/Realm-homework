import Security
import Foundation

class KeychainHelper {
    
    static let encryptionKeyIdentifier = "com.yourapp.realmEncryptionKey"

    // Извлечение ключа из Keychain
    static func getEncryptionKey() -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: encryptionKeyIdentifier,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else { return nil }
        return item as? Data
    }

    // Сохранение ключа в Keychain
    static func saveEncryptionKey(_ key: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: encryptionKeyIdentifier,
            kSecValueData as String: key
        ]
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    // Генерация нового ключа
    static func generateEncryptionKey() -> Data {
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        }
        return key
    }
}
