import RealmSwift

class RealmManager3 {
    static let shared = RealmManager3()
    let realm = try! Realm()
    private init() {}
    
    ///create
    func createData<T>(data: T) {
        do {
            try realm.write {
                if let dataArray = data as? [Object] {
                    realm.add(dataArray)
                } else if let object = data as? Object {
                    realm.add(object)
                } else {
                    print("Unsupported data type: \(type(of: data))")
                }
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
    ///read
    func readData<T: Object>(id: Int, type: T.Type) -> T? {
        let data = realm.object(ofType: type, forPrimaryKey: id)
        return data
    }
    ///update
    func updateData<T>(data: T) {
        do {
            try realm.write {
                if let dataArray = data as? [Object] {
                    realm.add(dataArray, update: .modified)
                } else if let object = data as? Object {
                    realm.add(object, update: .modified)
                }
                else {
                    print("Unsupported data type: \(type(of: data))")
                }
            }
        }
        catch {
            print("Error saving data: \(error)")
        }
    }
    ///delete
    func deleteData<T: Object>(_ data: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("Error deleting data: \(error)")
        }
    }
}



class RealmManager: DataManager {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    // create
    func createData<T>(data: T) {
        do {
            try realm.write {
                if let dataArray = data as? [Object] {
                    realm.add(dataArray)
                } else if let object = data as? Object {
                    realm.add(object)
                } else {
                    print("Unsupported data type: \(type(of: data))")
                }
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
    // read
    func readData<T: Object>(id: Int, type: T.Type) -> T? {
        let data = realm.object(ofType: type, forPrimaryKey: id)
        return data
    }
    // update
    func updateData<T: Object>(data: T, updateBlock: (T) -> Void) {
        do {
            try realm.write {
                updateBlock(data)
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
    // delete
    func deleteData<T>(data: T) {
        do {
            let realm = try Realm()
            try realm.write {
                if let data = data as? Object {
                    realm.delete(data)
                } else {
                    print("Unsupported data type: \(type(of: data))")
                }
            }
        } catch {
            print("Error deleting data: \(error)")
        }
    }
}
