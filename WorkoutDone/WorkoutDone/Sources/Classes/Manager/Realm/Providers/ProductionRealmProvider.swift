import Foundation

import RealmSwift

class ProductionRealmProvider: RealmProviderProtocol {
    func makeRealm() throws -> Realm {
        return try Realm()
    }
}
