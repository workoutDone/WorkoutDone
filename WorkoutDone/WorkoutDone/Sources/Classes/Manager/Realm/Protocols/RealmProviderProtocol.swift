import Foundation

import RealmSwift

protocol RealmProviderProtocol {
    func makeRealm() throws -> Realm
}
