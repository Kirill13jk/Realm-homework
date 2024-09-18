import RealmSwift
import Foundation

class QuoteCategory: Object {
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
