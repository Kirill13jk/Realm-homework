import RealmSwift
import Foundation

class ChuckNorrisQuote: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var category: String? = nil
    @objc dynamic var createdAt: Date = Date()

    override static func primaryKey() -> String? {
        return "id"
    }
}
