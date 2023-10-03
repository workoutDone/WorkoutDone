import Foundation

import RealmSwift

class MockRealmProvider: RealmProviderProtocol {
    func makeRealm() throws -> Realm {
        return try Realm(configuration: Realm.Configuration(inMemoryIdentifier: "testRealm"))
    }
}
