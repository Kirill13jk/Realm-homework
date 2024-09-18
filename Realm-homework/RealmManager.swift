import Security
import RealmSwift
import Foundation

class RealmManager {
    static let shared = RealmManager()
    
    private var realmInstance: Realm?

    private init() {
        do {
            realmInstance = try Realm()
            print("Realm успешно инициализирован по пути: \(String(describing: realmInstance?.configuration.fileURL))")
        } catch {
            print("Ошибка инициализации Realm: \(error)")
        }
    }
    
    func realm() -> Realm? {
        return realmInstance
    }

    private func retrieveOrGenerateEncryptionKey() -> Data {
        // Попытка получить ключ из Keychain
        if let savedKey = KeychainHelper.getEncryptionKey() {
            return savedKey
        } else {
            // Генерация нового ключа и сохранение его в Keychain
            let newKey = KeychainHelper.generateEncryptionKey()
            KeychainHelper.saveEncryptionKey(newKey)
            return newKey
        }
    }
}
